package me.zhengjie.provider.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.cloud.translate.Detection;
import com.google.cloud.translate.Translate;
import com.google.cloud.translate.TranslateOptions;
import com.google.cloud.translate.Translation;
import lombok.extern.slf4j.Slf4j;
import me.zhengjie.domain.TranslationProviders;
import me.zhengjie.provider.TranslationProvider;
import me.zhengjie.service.LanguageCodeMappingService;
import me.zhengjie.service.TranslationProvidersService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
@Service
@Slf4j
public class GoogleTranslationProvider implements TranslationProvider {
    private final TranslationProvidersService service;
    private final LanguageCodeMappingService codeMappingService;

    public GoogleTranslationProvider(
                                     TranslationProvidersService service,
                                     LanguageCodeMappingService codeMappingService) {
        this.service = service;
        this.codeMappingService = codeMappingService;
    }

    @Override
    public String translate(String text, String fromLang, String targetLang) throws Exception {
        // 从数据库获取 Google API 配置
        TranslationProviders config = service.getProviderConfig("Google");
        if (config == null) {
            throw new Exception("翻译服务未启用！");
        }
        // 获取API密钥、URL和附加配置信息
        String apiKey = config.getApiKey();

        // 查询对应的语言编码
        String apiTargetLang = codeMappingService.getApiLanguageCode("Google", targetLang);

        if (apiTargetLang == null) {
            log.error("语言编码未找到！to: {}", targetLang);
            throw new Exception("语言编码未找到！");
        }
// Create a service object
        //
        // If no explicit credentials or API key are set, requests are authenticated using Application
        // Default Credentials if available; otherwise, using an API key from the GOOGLE_API_KEY
        // environment variable
        Translate translate = TranslateOptions.newBuilder().setApiKey(apiKey).build().getService();
        // Detect the language of the mysterious text
        Detection detection = translate.detect(text);
        String detectedLanguage = detection.getLanguage();

        if (detectedLanguage.equals(targetLang)) return text;

        Translation translation =
                translate.translate(
                        text,
                        Translate.TranslateOption.sourceLanguage(detectedLanguage),
                        Translate.TranslateOption.targetLanguage(targetLang));
        return translation.getTranslatedText();
    }

    @Override
    public String getProviderName() {
        return "Google";
    }
}