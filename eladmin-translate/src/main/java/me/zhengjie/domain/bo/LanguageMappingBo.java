package me.zhengjie.domain.bo;

import lombok.Data;

import java.util.Map;

@Data
public class LanguageMappingBo {

    // 用于接收语言编码
    private String languageCode;

    // 用于接收平台语言编码的映射
    private Map<String, String> platformCodes;

    @Override
    public String toString() {
        return "LanguageMapping{" +
                "languageCode='" + languageCode + '\'' +
                ", platformCodes=" + platformCodes +
                '}';
    }
}