package me.zhengjie.domain;

import lombok.Data;

@Data
public class TranslationRequest {
    private String text;
    private String targetLang;
    private String fromLang;
    private String authCode;

}