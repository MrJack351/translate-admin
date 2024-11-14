package me.zhengjie.provider;

public interface TranslationProvider {
    String translate(String text, String fromLang, String targetLang) throws Exception;
    String getProviderName();  // 每个提供商的名称
}