package me.zhengjie.cache;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
public class TranslationCache {

    private final RedisTemplate<String, String> redisTemplate;

    public TranslationCache(RedisTemplate<String, String> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    // 根据 原文和目标语种 构建缓存 key
    private String buildCacheKey(String text, String targetLang) {
        return targetLang + "_" + text;
    }

    // 获取缓存的翻译结果
    public String getCachedTranslation(String text, String targetLang) {
        String key = buildCacheKey(text, targetLang);
        return redisTemplate.opsForValue().get(key);
    }

    // 缓存翻译结果
    public void cacheTranslation(String text,String translation,String targetLang) {
        String key = buildCacheKey(text,targetLang);
        redisTemplate.opsForValue().set(key, translation, Duration.ofHours(24));  // 缓存24小时
    }
}