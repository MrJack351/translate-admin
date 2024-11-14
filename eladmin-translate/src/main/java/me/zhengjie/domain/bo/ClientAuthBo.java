package me.zhengjie.domain.bo;

import lombok.Data;

@Data
public class ClientAuthBo {
    //时间戳
    private String timestamp;
    //加密数据
    private String jsonData;
}
