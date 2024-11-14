package me.zhengjie.domain.vo;

import lombok.Data;

@Data
public class AuthClientVo {
    // 机器码
    private String machineCode;
    // 授权码
    private String authCode;
    // 时间戳
    private String timestamp;
    // 到期时间
    private String expiryDate;
}
