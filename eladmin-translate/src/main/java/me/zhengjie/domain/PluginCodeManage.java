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
* @date 2024-10-21
**/
@Data
@TableName("plugin_code_manage")
public class PluginCodeManage implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty(value = "id")
    private Integer id;

    @NotBlank
    @ApiModelProperty(value = "平台名称")
    private String platformName;

    @ApiModelProperty(value = "js代码")
    private String jsCode;

    @ApiModelProperty(value = "创建时间")
    private Timestamp createdAt;

    @ApiModelProperty(value = "修改时间")
    private Timestamp updatedAt;

    @ApiModelProperty(value = "状态")
    private String status;

    public void copy(PluginCodeManage source){
        BeanUtil.copyProperties(source,this, CopyOptions.create().setIgnoreNullValue(true));
    }
}
