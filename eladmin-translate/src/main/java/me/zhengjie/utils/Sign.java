//package me.zhengjie.provider.impl;
//
//import cn.hutool.core.date.DatePattern;
//import cn.hutool.core.date.DateUtil;
//import cn.hutool.core.util.HexUtil;
//import cn.hutool.crypto.SecureUtil;
//import cn.hutool.crypto.digest.HMac;
//import cn.hutool.crypto.digest.HmacAlgorithm;
//import cn.hutool.json.JSONUtil;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import lombok.extern.slf4j.Slf4j;
//import me.zhengjie.domain.TranslationProviders;
//import me.zhengjie.provider.TranslationProvider;
//import me.zhengjie.service.TranslationProvidersService;
//import org.springframework.http.HttpEntity;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpMethod;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Service;
//import org.springframework.web.client.RestTemplate;
//
//import javax.crypto.Mac;
//import javax.crypto.spec.SecretKeySpec;
//import java.text.SimpleDateFormat;
//import java.util.*;
//
//@Service
//@Slf4j
//public class HuoshanTranslationProvider implements TranslationProvider {
//
//    private final RestTemplate restTemplate;
//    private final TranslationProvidersService service;
//
//    public HuoshanTranslationProvider(RestTemplate restTemplate, TranslationProvidersService service) {
//        this.restTemplate = restTemplate;
//        this.service = service;
//    }
//
//    @Override
//    public String translate(String text, String fromLang, String targetLang) throws Exception {
//        // 从数据库获取火山翻译的配置
//        TranslationProviders config = service.getProviderConfig("HuoShan");
//        if (config == null) {
//            return null;
//        }
//
//        // 使用数据库中存储的 URL 和 API Key，附加信息中的 sk 需要通过 JSON 转换后获得
//        String ak = config.getApiKey();
//        String url = config.getApiUrl();
//        String additionalConfig = config.getAdditionalConfig();  // 附加配置信息
//
//        // 解析附加配置信息，提取 sk
//        ObjectMapper mapper = new ObjectMapper();
//        Map<String, String> additionalParams = mapper.readValue(additionalConfig, Map.class);
//        String sk = additionalParams.get("sk");
//
//        // 构建 URL 查询参数（QueryString）
//        String currentVersion = "2020-06-01";  // 固定版本号
//        String requestUrl = url + "?Action=TranslateText&Version=" + currentVersion;
//
//        // 构建请求体
//        Map<String, Object> requestBody = new HashMap<>();
//        requestBody.put("TargetLanguage", targetLang);  // 目标语言
//        requestBody.put("TextList", new ArrayList<String>() {{
//            add(text);
//        }});
//
//        // 获取当前 UTC 时间，格式为 X-Date
//        SimpleDateFormat xDateFormat = new SimpleDateFormat("yyyyMMdd'T'HHmmss'Z'");
//        xDateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
//        String requestDateUtc = xDateFormat.format(new Date());  // 当前 UTC 时间
//        String payload = JSONUtil.toJsonStr(requestBody);
//
//        // Canonical Request 部分
//        String canonicalRequest =
//                "POST\n"
//                        + "/\n"
//                        + "Action=TranslateText&Version=2020-06-01\n"
//                        + "host:translate.volcengineapi.com\n"+"x-date:" + requestDateUtc + "\n"//CanonicalHeaders
//                        + "host;x-date\n"//signedHeaders
//                        + HexUtil.encodeHexStr(SecureUtil.sha256(payload));  // RequestPayload 请求体的SHA256哈希值
//
//
//        String CredentialScope = DateUtil.format(new Date(), DatePattern.PURE_DATE_PATTERN) + "/" + "cn-north-1/" + "translate/request";
//        String signedHeaders = "host;x-date";
//        String stringToSign = "HMAC-SHA256\n" + requestDateUtc + "\n" + CredentialScope + "\n" + HexUtil.encodeHexStr(SecureUtil.sha256(canonicalRequest));
//
//        // 计算签名
//        byte[] kDate = hmacSHA256(sk, DateUtil.format(new Date(), DatePattern.PURE_DATE_PATTERN));
//        byte[] kRegion = hmacSHA256(kDate, "cn-north-1");
//        byte[] kService = hmacSHA256(kRegion, "translate");
//        byte[] kSigning = hmacSHA256(kService, "request");
//
//        String signature = HexUtil.encodeHexStr(hmacSHA256(kSigning, stringToSign));
//
//        String authorization ="HMAC-SHA256 Credential=" + ak + "/" + CredentialScope + ", SignedHeaders=" + signedHeaders + ", Signature=" + signature;
//
//        // 设置请求头
//        HttpHeaders headers = new HttpHeaders();
////        headers.set("Content-Type", "application/json");
//        headers.set("Host", "translate.volcengineapi.com");
////        headers.set("X-Content-Sha256", SecureUtil.sha256(payload));
//        headers.set("X-Date", requestDateUtc);
//        headers.set("Authorization", authorization);  // 设置 Authorization 头部
//
//        // 构造请求
//        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
//
//        try {
//            // 发起 POST 请求
//            ResponseEntity<Map> response = restTemplate.exchange(requestUrl, HttpMethod.POST, entity, Map.class);
//
//            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
//                Map<String, Object> responseBody = response.getBody();
//                List<Map<String, Object>> translations = (List<Map<String, Object>>) responseBody.get("TranslationList");
//                if (!translations.isEmpty()) {
//                    return (String) translations.get(0).get("Translation");
//                }
//            } else {
//                log.error("请求失败，状态码: {}" ,response.getStatusCode());
//            }
//        } catch (Exception e) {
//            log.error("请求异常: {}" , e.getMessage());
//        }
//        return null;
//    }
//
//    @Override
//    public String getProviderName() {
//        return "HuoShan";
//    }
//
//    // HMAC-SHA256 计算方法
//    private byte[] hmacSHA256(String key, String data) {
//        HMac hMac = SecureUtil.hmac(HmacAlgorithm.HmacSHA256, key.getBytes());
//        return hMac.digest(data);
//    }
//
//    private byte[] hmacSHA256(byte[] key, String data) {
//        HMac hMac = SecureUtil.hmac(HmacAlgorithm.HmacSHA256, key);
//        return hMac.digest(data);
//    }
//}