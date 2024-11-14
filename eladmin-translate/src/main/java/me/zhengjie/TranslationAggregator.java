package me.zhengjie;

import lombok.extern.slf4j.Slf4j;
import me.zhengjie.cache.TranslationCache;
import me.zhengjie.domain.AuthManage;
import me.zhengjie.domain.LanguageList;
import me.zhengjie.domain.MessageCache;
import me.zhengjie.provider.TranslationProvider;
import me.zhengjie.service.AuthManageService;
import me.zhengjie.service.LanguageCodeMappingService;
import me.zhengjie.service.LanguageListService;
import me.zhengjie.service.MessageCacheService;
import me.zhengjie.utils.StringUtils;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Slf4j
public class TranslationAggregator {

    private final List<TranslationProvider> providers;
    private final TranslationCache cache;
    private final MessageCacheService messageCacheService;
    private final LanguageCodeMappingService codeMappingService;
    private final LanguageListService languageListService;
    private final AuthManageService authManageService;
    private int currentIndex = 0;  // 用于轮询选择Provider
    private static final long MAX_WAIT_TIME = 10000;  // 最大等待时间（毫秒）

    public TranslationAggregator(List<TranslationProvider> providers,
                                 TranslationCache cache,
                                 MessageCacheService messageCacheService,
                                 LanguageCodeMappingService codeMappingService,
                                 LanguageListService languageListService,AuthManageService authManageService) {
        this.providers = providers;
        this.cache = cache;
        this.messageCacheService = messageCacheService;
        this.codeMappingService = codeMappingService;
        this.languageListService = languageListService;
        this.authManageService = authManageService;
    }

    public String translate(String text, String fromLang, String targetLang,String authCode) throws Exception {
        //判断是否授权
        AuthManage authManage = authManageService.getAuthManageByAuthCode(authCode);
        if (authManage == null) {
            throw new Exception("未授权！");
        }
        Timestamp expiryDate = authManage.getExpiryDate();
        if (expiryDate.before(new Timestamp(System.currentTimeMillis()))) {
            throw new Exception("授权已过期！");
        }
        // 先检查缓存是否存在翻译结果
        String cachedTranslation = cache.getCachedTranslation(text, targetLang);
        if (cachedTranslation != null) {
            log.info("缓存命中，返回缓存的翻译结果: {} -> {}", text, cachedTranslation);
            return cachedTranslation;
        }
        // 检查语言编码是否正确
        LanguageList languageByCode = languageListService.getLanguageByCode(targetLang);
        if (languageByCode == null) {
            throw new Exception("语言编码不正确！");
        }

        // 查询是否存在缓存对象
        MessageCache messageCache = messageCacheService.getMessageCache(text, targetLang);
        if (messageCache != null && messageCache.getSourceText().equals(text) && messageCache.getStatus().equals("1") && messageCache.getLanguage().equals(targetLang)) {
            messageCache.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
            messageCacheService.updateMessageCache(messageCache);  // 更新数据库中的更新时间
            return messageCache.getTranslatedText();
        }

        // 初始化 MessageCache 对象
        if (messageCache == null) {
            messageCache = new MessageCache();
            messageCache.setSourceText(text);
            messageCache.setLanguage(targetLang);
            messageCache.setStatus("0");  // 状态为 0，表示正在翻译
            messageCache.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            messageCache.setAuthCode(authManage.getAuthCode());
            messageCacheService.create(messageCache);  // 插入一条初始记录
        }

        // 设置最大总尝试时间（例如10秒）
        long maxTotalRetryTime = 10000;  // 最大重试时间（毫秒）
        long startTime = System.currentTimeMillis();

        // 调用翻译逻辑，使用非递归方式以避免StackOverflowError
        return translateWithRetry(text, fromLang, targetLang, new HashSet<>(), 0, startTime, maxTotalRetryTime);
    }

    private String translateWithRetry(String text, String fromLang, String targetLang, Set<TranslationProvider> failedProviders, int attempt, long startTime, long maxTotalRetryTime) throws Exception {
        // 检查当前时间与开始时间的差值是否超过最大重试时间
        while (failedProviders.size() < providers.size()) {
            long currentTime = System.currentTimeMillis();
            if (currentTime - startTime > maxTotalRetryTime) {
                log.warn("翻译超时");
                return null;  // 超过最大重试时间，返回 null 结束请求
            }

            TranslationProvider selectedProvider = selectRoundRobinProvider(failedProviders);
            try {
                // 调用翻译服务
                String result = selectedProvider.translate(text, fromLang, targetLang);
                if (result != null && !StringUtils.isEmpty(result)) {
                    // 成功，缓存翻译结果并返回
                    cache.cacheTranslation(text, result, targetLang);

                    // 设置 MessageCache 信息
                    MessageCache messageCache = messageCacheService.getMessageCache(text, targetLang);
                    messageCache.setPlatform(selectedProvider.getProviderName());
                    messageCache.setTranslatedText(result);
                    messageCache.setStatus("1");  // 翻译成功
                    messageCache.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
                    messageCacheService.updateMessageCache(messageCache);  // 更新缓存记录

                    return result;
                }
            } catch (Exception e) {
                log.error("翻译提供商 {} 调用失败: {}", selectedProvider.getProviderName(), e.getMessage());
                // 如果某个提供商失败，记录错误并添加到失败的Provider集合中
                failedProviders.add(selectedProvider);

                // 如果所有提供商都失败，返回 null
                if (failedProviders.size() == providers.size()) {
                    log.warn("所有翻译提供商都失败");
                    return null;
                }

                // 指数退避机制：等待一段时间再尝试下一个提供商
                long waitTime = Math.min((long) (Math.pow(2, attempt) * 100), MAX_WAIT_TIME);  // 退避时间（毫秒），不超过最大等待时间
                log.info("等待 {} 毫秒后重试...", waitTime);
                Thread.sleep(waitTime);
            }
            attempt++;
        }

        // 如果所有提供商都失败，返回 null
        log.warn("所有翻译提供商都失败");
        return null;
    }

    // 使用轮询策略选择下一个可用的Provider
    private TranslationProvider selectRoundRobinProvider(Set<TranslationProvider> failedProviders) {
        int availableProvidersCount = providers.size();

        for (int i = 0; i < availableProvidersCount; i++) {
            TranslationProvider provider = providers.get((currentIndex + i) % availableProvidersCount);
            if (!failedProviders.contains(provider)) {
                currentIndex = (currentIndex + i + 1) % availableProvidersCount;  // 更新下一个轮询的起始位置
                return provider;
            }
        }

        throw new IllegalStateException("没有可用的翻译提供商");
    }
}