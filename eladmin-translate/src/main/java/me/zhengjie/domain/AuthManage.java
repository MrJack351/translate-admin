/*
*  Copyright 2019-2023 Zheng Jie
*
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*  http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
*/
package me.zhengjie.domain;

import lombok.Data;
import cn.hutool.core.bean.BeanUtil;
import io.swagger.annotations.ApiModelProperty;
import cn.hutool.core.bean.copier.CopyOptions;
import java.sql.Timestamp;
import java.io.Serializable;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
* @description /
* @author whh
* @date 2024-10-19
**/
@Data
@TableName("auth_manage")
public class AuthManage implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty(value = "ID")
    private Integer id;

    @ApiModelProperty(value = "授权码")
    private String authCode;

    @ApiModelProperty(value = "机器码")
    private String machineCode;

    @NotNull
    @ApiModelProperty(value = "失效时间")
    private Timestamp expiryDate;

    @ApiModelProperty(value = "可用字符串")
    private Long availableChars;

    @NotNull
    @ApiModelProperty(value = "总字符数")
    private Long totalChars;

    @ApiModelProperty(value = "创建时间")
    private Timestamp createdAt;

    @ApiModelProperty(value = "修改时间")
    private Timestamp updatedAt;

    @NotBlank
    @ApiModelProperty(value = "状态")
    private String status;

    @ApiModelProperty(value = "备注")
    private String remarks;

    public void copy(AuthManage source){
        BeanUtil.copyProperties(source,this, CopyOptions.create().setIgnoreNullValue(true));
    }
}
