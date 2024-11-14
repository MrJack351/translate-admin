package me.zhengjie.provider.impl;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.HexUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.crypto.digest.HMac;
import cn.hutool.crypto.digest.HmacAlgorithm;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.volcengine.model.request.translate.LangDetectRequest;
import com.volcengine.model.request.translate.TranslateTextRequest;
import com.volcengine.model.response.translate.LangDetectResponse;
import com.volcengine.model.response.translate.TranslateTextResponse;
import com.volcengine.service.translate.ITranslateService;
import com.volcengine.service.translate.impl.TranslateServiceImpl;
import lombok.extern.slf4j.Slf4j;
import me.zhengjie.domain.TranslationProviders;
import me.zhengjie.provider.TranslationProvider;
import me.zhengjie.service.LanguageCodeMappingService;
import me.zhengjie.service.TranslationProvidersService;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
@Slf4j
public class HuoshanTranslationProvider implements TranslationProvider {

    private final RestTemplate restTemplate;
    private final TranslationProvidersService service;
    private final LanguageCodeMappingService codeMappingService;

    public HuoshanTranslationProvider(RestTemplate restTemplate, TranslationProvidersService service,LanguageCodeMappingService codeMappingService) {
        this.restTemplate = restTemplate;
        this.service = service;
        this.codeMappingService = codeMappingService;
    }

    @Override
    public String translate(String text, String fromLang, String targetLang) throws Exception {

        // 从数据库获取火山翻译的配置
        TranslationProviders config = service.getProviderConfig("HuoShan");
        if (config == null) {
            throw new Exception("翻译服务未启用");
        }

        // 使用数据库中存储的 URL 和 API Key，附加信息中的 sk 需要通过 JSON 转换后获得
        String ak = config.getApiKey();
        String additionalConfig = config.getAdditionalConfig();  // 附加配置信息

        // 解析附加配置信息，提取 sk
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> additionalParams = mapper.readValue(additionalConfig, Map.class);
        String sk = additionalParams.get("sk");

        // 查询对应的语言编码（source语言和目标语言的映射）
        String apiTargetLang = codeMappingService.getApiLanguageCode("HuoShan", targetLang);
        if (apiTargetLang == null) {
            log.error("语言编码未找到！{}",targetLang);
            throw new Exception("语言编码未找到！");
        }
        ITranslateService translateService = TranslateServiceImpl.getInstance();
        // call below method if you dont set ak and sk in ～/.volc/config
        translateService.setAccessKey(ak);
        translateService.setSecretKey(sk);
        // translate text
        try {
            TranslateTextRequest translateTextRequest = new TranslateTextRequest();
            // translateTextRequest.setSourceLanguage("en"); // 不设置表示自动检测
            translateTextRequest.setTargetLanguage(apiTargetLang);
            translateTextRequest.setTextList(Arrays.asList(text));
            TranslateTextResponse translateText = translateService.translateText(translateTextRequest);
            // 提取翻译结果
            if (translateText != null && translateText.getTranslationList() != null && !translateText.getTranslationList().isEmpty()) {
                String translatedText = translateText.getTranslationList().get(0).getTranslation();
                return translatedText;  // 直接返回翻译的值
            }
        } catch (Exception e) {
            log.error(e.getMessage());
            throw new Exception(e.getMessage());
        }
        throw new Exception("未知错误！");
    }

    @Override
    public String getProviderName() {
        return "HuoShan";
    }
}