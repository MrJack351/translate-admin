package me.zhengjie.provider.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import me.zhengjie.domain.TranslationProviders;
import me.zhengjie.provider.TranslationProvider;
import me.zhengjie.service.LanguageCodeMappingService;
import me.zhengjie.service.TranslationProvidersService;
import me.zhengjie.utils.AuthV3Util;
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

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
@Slf4j
public class YoudaoTranslationProvider implements TranslationProvider {

    private final RestTemplate restTemplate;
    private final TranslationProvidersService service;
    private final LanguageCodeMappingService codeMappingService;
    private final ObjectMapper objectMapper;

    public YoudaoTranslationProvider(RestTemplate restTemplate,
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
        // 从数据库获取 YouDao API 配置
        TranslationProviders config = service.getProviderConfig("YouDao");
        if (config == null) {
            throw new Exception("翻译服务未启用！");
        }

        // 获取API密钥、URL和附加配置信息
        String apiKey = config.getApiKey();
        String apiUrl = config.getApiUrl();
        String additionalConfig = config.getAdditionalConfig();

        // 解析 additionalConfig 获取 appKey
        String appKey;
        try {
            JsonNode configNode = objectMapper.readTree(additionalConfig);
            appKey = configNode.get("appKey").asText();
        } catch (Exception e) {
            log.error("appKey参数未找到！ ");
            throw new Exception("appKey参数未找到！");
        }

        // 查询对应的语言编码（source语言和目标语言的映射）
        String apiTargetLang = codeMappingService.getApiLanguageCode("YouDao", targetLang);
//        String apiFromLang = codeMappingService.getApiLanguageCode("YouDao", fromLang);

        if (apiTargetLang == null) {
            log.error("语言编码未找到！{}",targetLang);
            throw new Exception("语言编码未找到！");
        }

        // 生成随机字符串和当前时间戳（秒）
        String salt = UUID.randomUUID().toString();
        String curtime = String.valueOf(System.currentTimeMillis() / 1000);
        // 生成签名
        String sign = generateSign(appKey, apiKey, text, salt, curtime);

//        String sign = AuthV3Util.calculateSign(appKey, apiKey, text, salt, curtime);

        // 构建请求体，使用 LinkedMultiValueMap 以确保参数以表单格式发送
        MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<>();
        requestBody.add("q", text);  // 确保文本是 UTF-8 编码
        requestBody.add("from", "auto");
        requestBody.add("to", apiTargetLang);
        requestBody.add("appKey", appKey);
        requestBody.add("salt", salt);
        requestBody.add("sign", sign);
        requestBody.add("signType", "v3");
        requestBody.add("curtime", curtime);
        requestBody.add("strict", "true");

        // 创建请求头
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded;");

        // 创建请求实体，使用 LinkedMultiValueMap
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(requestBody, headers);


        // 发起 HTTP POST 请求获取翻译结果
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
    private String generateSign(String appKey, String appSecret, String text, String salt, String curtime) {
        String input = text.length() <= 20 ? text : (text.substring(0, 10) + text.length() + text.substring(text.length() - 10));
        String signString = appKey + input + salt + curtime + appSecret;
        return SecureUtil.sha256(signString);  // 使用Hutool库生成SHA-256签名
    }

    // 解析翻译API返回的JSON响应
    private String parseTranslationResponse(String response) throws Exception {
        JsonNode root = objectMapper.readTree(response);

        if (root.has("translation")) {
            // 获取 "translation" 数组
            JsonNode translationArray = root.get("translation");

            // 检查数组是否有值，并返回第一个翻译结果
            if (translationArray.isArray() && translationArray.size() > 0) {
                return translationArray.get(0).asText();  // 获取数组中的第一个翻译结果
            }
        }
        throw new Exception(response);
    }

    // 处理API返回的状态码
    private void handleErrorCode(ResponseEntity<String> response) throws Exception {
        JsonNode root = objectMapper.readTree(response.getBody());
        if (root.has("errorCode") && root.has("errorMessage")) {
            String errorCode = root.get("errorCode").asText();
            String errorMsg = root.get("errorMessage").asText();

            switch (errorCode) {
                case "101":
                    throw new Exception("Error 101: 缺少必填的参数 - " + errorMsg);
                case "102":
                    throw new Exception("Error 102: 不支持的语言类型 - " + errorMsg);
                case "103":
                    throw new Exception("Error 103: 翻译文本过长 - " + errorMsg);
                case "104":
                    throw new Exception("Error 104: 不支持的API类型 - " + errorMsg);
                case "105":
                    throw new Exception("Error 105: 不支持的签名类型 - " + errorMsg);
                case "106":
                    throw new Exception("Error 106: 不支持的响应类型 - " + errorMsg);
                case "107":
                    throw new Exception("Error 107: 该接口已关闭 - " + errorMsg);
                case "108":
                    throw new Exception("Error 108: 访问IP地址不在可访问IP列表 - " + errorMsg);
                case "109":
                    throw new Exception("Error 109: 账号余额不足 - " + errorMsg);
                case "110":
                    throw new Exception("Error 110: 访问频率受限 - " + errorMsg);
                default:
                    throw new Exception("Unknown Error Code: " + errorCode + " - " + errorMsg);
            }
        } else {
            throw new Exception("Unknown response format: " + response.getBody());
        }
    }

    @Override
    public String getProviderName() {
        return "YouDao";
    }
}