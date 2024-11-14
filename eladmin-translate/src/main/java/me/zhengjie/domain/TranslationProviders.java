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

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import cn.hutool.core.bean.BeanUtil;
import io.swagger.annotations.ApiModelProperty;
import cn.hutool.core.bean.copier.CopyOptions;
import java.sql.Timestamp;
import java.io.Serializable;
import java.util.Map;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
* @description /
* @author whh
* @date 2024-10-16
**/
@Data
@TableName("translation_providers")
public class TranslationProviders implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty(value = "主键")
    private Integer id;

    @NotBlank
    @ApiModelProperty(value = "服务提供商")
    private String providerName;

    @NotBlank
    @ApiModelProperty(value = "API Key")
    private String apiKey;

    @NotBlank
    @ApiModelProperty(value = "API Url")
    private String apiUrl;

    @NotBlank
    @ApiModelProperty(value = "启用状态")
    private String status;

    @ApiModelProperty(value = "附加配置信息(headers或特定参数)")
    private String additionalConfig;

    @ApiModelProperty(value = "语言列表")
    private String supportedLanguages;

    @ApiModelProperty(value = "创建时间")
    private Timestamp createdAt;

    @ApiModelProperty(value = "更新时间")
    private Timestamp updatedAt;

    public void copy(TranslationProviders source){
        BeanUtil.copyProperties(source,this, CopyOptions.create().setIgnoreNullValue(true));
    }
}
