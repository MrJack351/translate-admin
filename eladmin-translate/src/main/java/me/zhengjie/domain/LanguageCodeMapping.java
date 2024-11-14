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

/**
* @description /
* @author whh
* @date 2024-10-16
**/
@Data
@TableName("language_code_mapping")
public class LanguageCodeMapping implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty(value = "id")
    private Integer id;

    @NotBlank
    @ApiModelProperty(value = "系统语言编码")
    private String systemLanguageCode;

    @NotBlank
    @ApiModelProperty(value = "服务商")
    private String apiName;

    @NotBlank
    @ApiModelProperty(value = "API语言编码")
    private String apiLanguageCode;

    @ApiModelProperty(value = "创建时间")
    private Timestamp createdAt;

    @ApiModelProperty(value = "修改时间")
    private Timestamp updatedAt;

    public void copy(LanguageCodeMapping source){
        BeanUtil.copyProperties(source,this, CopyOptions.create().setIgnoreNullValue(true));
    }
}
