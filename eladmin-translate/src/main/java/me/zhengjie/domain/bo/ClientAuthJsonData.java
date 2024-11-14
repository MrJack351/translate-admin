package me.zhengjie.domain.bo;

import lombok.Data;

@Data
public class ClientAuthJsonData {
    // 机器码
    private String machineCode;
    // 授权码
    private String authCode;
    // 时间戳
    private String timestamp;
}