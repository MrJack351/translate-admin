package me.zhengjie.provider.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import me.zhengjie.domain.TranslationProviders;
import me.zhengjie.provider.TranslationProvider;
import me.zhengjie.service.LanguageCodeMappingService;
import me.zhengjie.service.TranslationProvidersService;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.HashMap;
import java.util.Map;

@Service
public class NiuTransTranslationProvider implements TranslationProvider {

    private final RestTemplate restTemplate;
    private final TranslationProvidersService service;
    private final LanguageCodeMappingService codeMappingService;
    private final ObjectMapper objectMapper;

    public NiuTransTranslationProvider(RestTemplate restTemplate,
                                       TranslationProvidersService service,
                                       LanguageCodeMappingService codeMappingService,
                                       ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.service = service;
        this.codeMappingService = codeMappingService;
        this.objectMapper = objectMapper;
    }

    @Override
    public String translate(String text, String fromLang, String targetLang) throws Exception {
        // 从数据库获取 NiuTrans API 配置
        TranslationProviders config = service.getProviderConfig("NiuTrans");
        if (config == null) {
            throw new Exception("翻译服务未启用！");
        }
        // 获取API密钥
        String apiKey = config.getApiKey();

        // 查询对应的语言编码（source语言和目标语言的映射）
        String apiTargetLang = codeMappingService.getApiLanguageCode("NiuTrans", targetLang);
//        String apiFromLang = codeMappingService.getApiLanguageCode("NiuTrans", fromLang);

        if (apiTargetLang == null) {
            throw new Exception("语言编码未找到：" + targetLang);
        }

//        if (apiFromLang == null) {
//            throw new Exception("语言编码未找到: " + fromLang);
//        }

        // 构建请求体
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("apikey", apiKey);
        requestBody.put("from", "auto");
        requestBody.put("to", apiTargetLang);
        requestBody.put("src_text", text);

        // 创建请求头
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        // 创建请求实体
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        // 发起 HTTP POST 请求获取翻译结果
        String url = config.getApiUrl();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

        // 检查状态码并处理响应
        if (response.getStatusCode() == HttpStatus.OK) {
            return parseTranslationResponse(response.getBody());
        }
        throw new Exception(String.valueOf(response));
    }

    // 解析翻译API返回的JSON响应
    private String parseTranslationResponse(String response) throws Exception {
        JsonNode root = objectMapper.readTree(response);

        if (root.has("tgt_text")) {
            return root.get("tgt_text").asText();
        } else {
            throw new Exception("Translation response does not contain 'tgt_text': " + response);
        }
    }

    // 处理API返回的状态码
    private void handleErrorCode(ResponseEntity<String> response) throws Exception {
        JsonNode root = objectMapper.readTree(response.getBody());
        if (root.has("error_code") && root.has("error_msg")) {
            String errorCode = root.get("error_code").asText();
            String errorMsg = root.get("error_msg").asText();

            switch (errorCode) {
                case "10000":
                    throw new Exception("Error 10000: 输入为空 - " + errorMsg);
                case "10001":
                    throw new Exception("Error 10001: 请求频繁，超出QPS限制 - " + errorMsg);
                case "10003":
                    throw new Exception("Error 10003: 请求字符串长度超过限制 - " + errorMsg);
                case "10005":
                    throw new Exception("Error 10005: 源语编码有问题，非UTF-8 - " + errorMsg);
                case "13001":
                    throw new Exception("Error 13001: 字符流量不足或者没有访问权限 - " + errorMsg);
                case "13002":
                    throw new Exception("Error 13002: API密钥为空 - " + errorMsg);
                case "13003":
                    throw new Exception("Error 13003: 内容过滤异常 - " + errorMsg);
                case "13006":
                    throw new Exception("Error 13006: 参数不支持 - " + errorMsg);
                case "13007":
                    throw new Exception("Error 13007: 语言不支持 - " + errorMsg);
                case "13008":
                    throw new Exception("Error 13008: 请求处理超时 - " + errorMsg);
                case "000000":
                    throw new Exception("Error 000000: 请求参数有误，请检查参数 - " + errorMsg);
                case "000001":
                    throw new Exception("Error 000001: Content-Type或Request-Method 不支持 - " + errorMsg);
                default:
                    throw new Exception("Unknown Error Code: " + errorCode + " - " + errorMsg);
            }
        } else {
            throw new Exception("Unknown response format: " + response.getBody());
        }
    }

    @Override
    public String getProviderName() {
        return "NiuTrans";
    }
}