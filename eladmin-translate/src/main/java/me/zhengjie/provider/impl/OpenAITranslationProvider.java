package me.zhengjie.provider.impl;

import lombok.extern.slf4j.Slf4j;
import me.zhengjie.domain.TranslationProviders;
import me.zhengjie.provider.TranslationProvider;
import me.zhengjie.service.TranslationProvidersService;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

@Service
@Slf4j
public class OpenAITranslationProvider implements TranslationProvider {

    private final RestTemplate restTemplate;
    private final TranslationProvidersService service;

    public OpenAITranslationProvider(RestTemplate restTemplate, TranslationProvidersService service) {
        this.restTemplate = restTemplate;
        this.service = service;
    }

    @Override
    public String translate(String text,String fromLang, String targetLang) throws Exception {
        // 从数据库获取 OpenAI 配置
        TranslationProviders config = service.getProviderConfig("OpenAI");
        if (config == null) {
            throw new Exception("服务未启用！");
        }

        // 使用数据库中存储的 URL 和 API Key
        String apiKey = config.getApiKey();
        String url = config.getApiUrl();

        // 构建请求体，基于 gpt-3.5-turbo 模型
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", "gpt-3.5-turbo");

        // OpenAI GPT 对话消息体
        Map<String, String> systemMessage = new HashMap<>();
        systemMessage.put("role", "system");
        systemMessage.put("content", "You are a professional, authentic machine translation engine.");

        Map<String, String> userMessage = new HashMap<>();
        userMessage.put("role", "user");
        userMessage.put("content", String.format(
                "Translate the following text to %s. Output the translation directly without any additional text. Text: %s",
                targetLang, text));

        // 使用传统方式初始化 List
        List<Map<String, String>> messages = new ArrayList<>();
        messages.add(systemMessage);
        messages.add(userMessage);

        requestBody.put("messages", messages);
        requestBody.put("max_tokens", 1000);
        requestBody.put("temperature", 0.3);

        // 设置请求头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(apiKey);

        // 构造请求
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        try {
            // 发起 POST 请求
            ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                // 从返回的数据中提取翻译结果
                Map<String, Object> responseBody = response.getBody();
                List<Map<String, Object>> choices = (List<Map<String, Object>>) responseBody.get("choices");
                if (!choices.isEmpty()) {
                    Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");
                    String translatedText = (String) message.get("content");
                    return translatedText.trim();
                }
            } else {
                System.err.println("请求失败，状态码: " + response.getStatusCode());
                throw new Exception(response.toString());
            }
        } catch (Exception e) {
            System.err.println("OpenAI翻译请求发生异常: " + e.getMessage());
            throw e;
        }
        return null;
    }

    @Override
    public String getProviderName() {
        return "OpenAI";
    }
}