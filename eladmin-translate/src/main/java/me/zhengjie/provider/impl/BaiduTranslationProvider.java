package me.zhengjie.provider.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
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
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import cn.hutool.crypto.SecureUtil;

import java.util.UUID;

@Service
@Slf4j
public class BaiduTranslationProvider implements TranslationProvider {

    private final RestTemplate restTemplate;
    private final TranslationProvidersService service;
    private final LanguageCodeMappingService codeMappingService;
    private final ObjectMapper objectMapper;

    public BaiduTranslationProvider(RestTemplate restTemplate,
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
        // 从数据库获取 Baidu API 配置
        TranslationProviders config = service.getProviderConfig("Baidu");
        if (config == null) {
            throw new Exception("翻译服务未启用！");
        }

        // 获取API密钥、URL和附加配置信息
        String apiKey = config.getApiKey();
        String apiUrl = config.getApiUrl();
        String additionalConfig = config.getAdditionalConfig();

        // 解析 additionalConfig 获取 appId
        String appId;
        try {
            JsonNode configNode = objectMapper.readTree(additionalConfig);
            appId = configNode.get("appId").asText();  // 提取 "appId" 的值
        } catch (Exception e) {
            log.error("appId参数未找到！", e);
            throw new Exception("appId 参数未找到！");
        }

        // 查询对应的语言编码
        String apiTargetLang = codeMappingService.getApiLanguageCode("Baidu", targetLang);

        if (apiTargetLang == null) {
            log.error("语言编码未找到！to: {}", targetLang);
            throw new Exception("语言编码未找到！");
        }

        // 生成随机字符串和盐值
        String salt = UUID.randomUUID().toString();
        String sign = generateSign(appId, apiKey, text, salt);

        // 构建请求体
        MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<>();
        requestBody.add("q", text);
        requestBody.add("from", "auto");
        requestBody.add("to", apiTargetLang);
        requestBody.add("appid", appId);
        requestBody.add("salt", salt);
        requestBody.add("sign", sign);

        // 创建请求头
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");

        // 发送请求
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(requestBody, headers);
        ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.POST, entity, String.class);

        // 检查状态码并处理响应
        if (response.getStatusCode() == HttpStatus.OK) {
            return parseTranslationResponse(response.getBody());
        } else {
            handleErrorCode(response);
            throw new Exception(String.valueOf(response));
        }
    }

    // 生成签名方法
    private String generateSign(String appId, String secretKey, String text, String salt) {
        // 签名规则：MD5(appid+q+salt+密钥)
        String signString = appId + text + salt + secretKey;
        return SecureUtil.md5(signString);  // 使用Hutool库生成MD5签名
    }

    // 解析百度翻译API返回的JSON响应
    private String parseTranslationResponse(String response) throws Exception {
        JsonNode root = objectMapper.readTree(response);

        if (root.has("trans_result")) {
            // 获取 "trans_result" 数组
            JsonNode translationArray = root.get("trans_result");

            // 检查数组是否有值，并返回第一个翻译结果
            if (translationArray.isArray() && !translationArray.isEmpty()) {
                return translationArray.get(0).get("dst").asText();  // 获取数组中的第一个翻译结果的 "dst" 字段
            }
        }
        throw new Exception(response);
    }

    // 处理API返回的错误代码
    private void handleErrorCode(ResponseEntity<String> response) throws Exception {
        JsonNode root = objectMapper.readTree(response.getBody());
        if (root.has("error_code") && root.has("error_msg")) {
            String errorCode = root.get("error_code").asText();
            String errorMsg = root.get("error_msg").asText();

            throw new Exception("Error " + errorCode + ": " + errorMsg);
        } else {
            throw new Exception("Unknown response format: " + response.getBody());
        }
    }

    @Override
    public String getProviderName() {
        return "Baidu";
    }
}