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
package me.zhengjie.rest;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.crypto.asymmetric.RSA;
import cn.hutool.json.JSONUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import me.zhengjie.annotation.AnonymousAccess;
import me.zhengjie.annotation.Log;
import me.zhengjie.base.ApiResponse;
import me.zhengjie.config.RsaProperties;
import me.zhengjie.domain.AuthManage;
import me.zhengjie.domain.bo.ClientAuthBo;
import me.zhengjie.domain.bo.ClientAuthJsonData;
import me.zhengjie.domain.vo.AuthClientVo;
import me.zhengjie.service.AuthManageService;
import me.zhengjie.domain.vo.AuthManageQueryCriteria;
import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.List;

import me.zhengjie.utils.ApiResponseUtil;
import me.zhengjie.utils.RsaUtils;
import me.zhengjie.utils.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import io.swagger.annotations.*;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import me.zhengjie.utils.PageResult;

/**
* @author whh
* @date 2024-10-19
**/
@RestController
@RequiredArgsConstructor
@Api(tags = "设备授权管理")
@RequestMapping("/api/authManage")
public class AuthManageController {

    private final AuthManageService authManageService;


    @PostMapping("/clientAuth")
    @Log("易语言客户端授权")
    @ApiOperation("易语言客户端授权")
    @AnonymousAccess
    public ApiResponse clientAuth(@RequestBody ClientAuthBo authBo){
        String authBoTimestamp = authBo.getTimestamp();
        if (StringUtils.isEmpty(authBoTimestamp) || StringUtils.isEmpty(authBo.getJsonData()))
            return ApiResponseUtil.error(-1,"参数错误");
        String privateKey = RsaProperties.privateKey;
        String publicKey = RsaProperties.publicKey;
        try {
            String jsonBo = RsaUtils.decryptByPrivateKey(privateKey, authBo.getJsonData());
            // 使用 Jackson 进行转换
            ObjectMapper objectMapper = new ObjectMapper();
            ClientAuthJsonData jsonData = objectMapper.readValue(jsonBo, ClientAuthJsonData.class);
            String machineCode = jsonData.getMachineCode();
            String authCode = jsonData.getAuthCode();
            String timestamp = jsonData.getTimestamp();
            //比对时间戳是否正确
            if (!timestamp.equals(authBoTimestamp)) {
                return ApiResponseUtil.error(-1,"timestamp验证失败");
            }
            //判断是否存在机器码
            if (StringUtils.isEmpty(machineCode)) {
                return ApiResponseUtil.error(-1,"机器码不能为空");
            }
            //判断机器码是否存在授权记录
            AuthClientVo authClientVo = authManageService.checkMachineCode(machineCode);
            if (authClientVo != null) {
                String jsonStr = JSONUtil.toJsonStr(authClientVo);
                ClientAuthBo clientAuthBo = new ClientAuthBo();

                clientAuthBo.setJsonData(RsaUtils.encryptByPublicKey(publicKey, jsonStr));
                clientAuthBo.setTimestamp(authClientVo.getTimestamp());
                return ApiResponseUtil.success(200,"success",clientAuthBo);
            }
            //判断是否是新用户
            if (StringUtils.isEmpty(authCode)) {
                //授权码为空，生成试用账号
                AuthClientVo clientVo = authManageService.createTrial(machineCode);
                String jsonStr = JSONUtil.toJsonStr(clientVo);
                ClientAuthBo clientAuthBo = new ClientAuthBo();
                clientAuthBo.setJsonData(RsaUtils.encryptByPublicKey(publicKey, jsonStr));
                clientAuthBo.setTimestamp(clientVo.getTimestamp());
                return ApiResponseUtil.success(200,"success",clientAuthBo);
            }
            //根据授权码查询用户信息
            AuthClientVo authClient = authManageService.getAuthClient(authCode);
            if (authClient == null)return ApiResponseUtil.error(-1,"授权码无效");
            String jsonStr = JSONUtil.toJsonStr(authClient);
            ClientAuthBo clientAuthBo = new ClientAuthBo();
            clientAuthBo.setJsonData(RsaUtils.encryptByPrivateKey(privateKey, jsonStr));
            clientAuthBo.setTimestamp(authClient.getTimestamp());
            return ApiResponseUtil.success(200,"success",clientAuthBo);
        } catch (Exception e) {
            return ApiResponseUtil.error(-1,"验证失败");
        }
    }


    @Log("导出数据")
    @ApiOperation("导出数据")
    @GetMapping(value = "/download")
    @PreAuthorize("@el.check('authManage:list')")
    public void exportAuthManage(HttpServletResponse response, AuthManageQueryCriteria criteria) throws IOException {
        authManageService.download(authManageService.queryAll(criteria), response);
    }

    @GetMapping
    @Log("查询设备授权")
    @ApiOperation("查询设备授权")
    @PreAuthorize("@el.check('authManage:list')")
    public ResponseEntity<PageResult<AuthManage>> queryAuthManage(AuthManageQueryCriteria criteria, Page<Object> page){
        return new ResponseEntity<>(authManageService.queryAll(criteria,page),HttpStatus.OK);
    }

    @PostMapping
    @Log("新增设备授权")
    @ApiOperation("新增设备授权")
    @PreAuthorize("@el.check('authManage:add')")
    public ResponseEntity<Object> createAuthManage(@Validated @RequestBody AuthManage resources){
        authManageService.create(resources);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PutMapping
    @Log("修改设备授权")
    @ApiOperation("修改设备授权")
    @PreAuthorize("@el.check('authManage:edit')")
    public ResponseEntity<Object> updateAuthManage(@Validated @RequestBody AuthManage resources){
        authManageService.update(resources);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping
    @Log("删除设备授权")
    @ApiOperation("删除设备授权")
    @PreAuthorize("@el.check('authManage:del')")
    public ResponseEntity<Object> deleteAuthManage(@RequestBody List<Integer> ids) {
        authManageService.deleteAll(ids);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}