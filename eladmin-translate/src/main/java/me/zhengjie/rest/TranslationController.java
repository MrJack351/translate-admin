package me.zhengjie.rest;

import cn.hutool.core.codec.Base64;
import cn.hutool.core.lang.UUID;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.crypto.symmetric.AES;
import cn.hutool.json.JSONUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import me.zhengjie.TranslationAggregator;
import me.zhengjie.annotation.AnonymousAccess;
import me.zhengjie.base.ApiResponse;
import me.zhengjie.config.RsaProperties;
import me.zhengjie.domain.PluginCodeManage;
import me.zhengjie.domain.TranslationRequest;
import me.zhengjie.domain.bo.ClientAuthBo;
import me.zhengjie.service.PluginCodeManageService;
import me.zhengjie.utils.ApiResponseUtil;
import me.zhengjie.utils.RedisUtils;
import me.zhengjie.utils.RsaUtils;
import me.zhengjie.utils.StringUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/api")
@Api(tags = "翻译：文本翻译")
public class TranslationController {

    private final TranslationAggregator translationAggregator;
    private final PluginCodeManageService pluginCodeManageService;

    private final RedisUtils redisUtils;

    public TranslationController(TranslationAggregator translationAggregator, PluginCodeManageService pluginCodeManageService, RedisUtils redisUtils) {
        this.translationAggregator = translationAggregator;
        this.pluginCodeManageService = pluginCodeManageService;
        this.redisUtils = redisUtils;
    }

    @PostMapping("/translate")
    @ApiOperation("文本翻译")
    @AnonymousAccess
    public ApiResponse translate(@RequestBody TranslationRequest request) {
        String text = request.getText();
        String requestHash = DigestUtils.md5Hex(request.getTargetLang() + request.getText()); // 基于内容生成哈希

        if (StringUtils.isEmpty(requestHash) || redisUtils.hasKey(requestHash)) {
            return ApiResponseUtil.error(-1, "重复请求，请稍后再试！");
        }

        if (text.length() > 5000) {
            return ApiResponseUtil.error(-1, "翻译文本长度超过5000，请分段翻译！");
        }
        if (StringUtils.isEmpty(text)) {
            return ApiResponseUtil.error(-1, "翻译文本为空！");
        }

        try {
            // 将请求哈希存入Redis，并设置过期时间
            boolean success = redisUtils.set(requestHash, true, 60, TimeUnit.SECONDS);
            if (!success) {
                return ApiResponseUtil.error(-1, "请求缓存失败，请稍后重试！");
            }

            String translate = translationAggregator.translate(request.getText(), request.getFromLang(), request.getTargetLang(), request.getAuthCode());
            if (translate == null) {
                return ApiResponseUtil.error(-1, "翻译失败！");
            }

            return ApiResponseUtil.success(200, "success", translate);
        } catch (Exception e) {
            return ApiResponseUtil.error(-1, e.getMessage());
        } finally {
            // 处理完请求后，删除Redis中的记录
            redisUtils.del(requestHash);
        }
    }

    @ApiOperation("获取插件代码")
    @GetMapping("/pluginCode/{name}")
    @AnonymousAccess
    public ApiResponse getPluginCode(@PathVariable String name) {
        // 获取插件代码
        PluginCodeManage pluginCode = pluginCodeManageService.getPluginCode(name);
        if (pluginCode == null) {
            return ApiResponseUtil.error(-1, "插件不存在或未启用！");
        }

        // 创建返回数据对象
        ClientAuthBo bo = new ClientAuthBo();
        String time = String.valueOf(System.currentTimeMillis());
        String publicKey = RsaProperties.publicKey;  // 私钥
        String jsCode = pluginCode.getJsCode();  // 要加密的插件代码

        try {
            HashMap<String, String> map = new HashMap<>();

            // 1. 生成随机AES密钥
            AES aes = SecureUtil.aes();
            String aesKey = aes.getSecretKey().getEncoded().toString();  // AES密钥

            // 2. 使用AES加密jsCode
//            String encryptedJsCode = aes.encryptBase64(jsCode);
            String encryptedJsCode = Base64.encode(jsCode);


            // 3. 使用RSA私钥加密AES密钥
            String encryptedAesKey = RsaUtils.encryptByPublicKey(publicKey, aesKey);

            // 4. 将加密后的AES密钥和加密后的jsCode传给前端
            map.put("timestamp", RsaUtils.encryptByPublicKey(publicKey, time));
            map.put("jsCode", encryptedJsCode);
            map.put("aesKey", encryptedAesKey);  // 传递加密后的AES密钥

            // 5. 返回加密后的数据
            bo.setJsonData(JSONUtil.toJsonStr(map));  // 将map转换为JSON字符串
            bo.setTimestamp(time);

            return ApiResponseUtil.success(200, "success", bo);
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResponseUtil.error(-1, "系统内部错误！");
        }
    }
}