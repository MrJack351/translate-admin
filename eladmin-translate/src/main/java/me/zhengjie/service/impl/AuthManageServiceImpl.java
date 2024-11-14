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
package me.zhengjie.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.UUID;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import me.zhengjie.domain.AuthManage;
import me.zhengjie.domain.vo.AuthClientVo;
import me.zhengjie.exception.EntityExistException;
import me.zhengjie.utils.FileUtil;
import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import me.zhengjie.service.AuthManageService;
import me.zhengjie.domain.vo.AuthManageQueryCriteria;
import me.zhengjie.mapper.AuthManageMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import me.zhengjie.utils.PageUtil;

import java.sql.Timestamp;
import java.util.*;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;

import me.zhengjie.utils.PageResult;

/**
* @description 服务实现
* @author whh
* @date 2024-10-19
**/
@Service
@RequiredArgsConstructor
public class AuthManageServiceImpl extends ServiceImpl<AuthManageMapper, AuthManage> implements AuthManageService {

    private final AuthManageMapper authManageMapper;

    @Override
    public PageResult<AuthManage> queryAll(AuthManageQueryCriteria criteria, Page<Object> page){
        return PageUtil.toPage(authManageMapper.findAll(criteria, page));
    }

    @Override
    public List<AuthManage> queryAll(AuthManageQueryCriteria criteria){
        return authManageMapper.findAll(criteria);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(AuthManage resources) {
        resources.setAuthCode(UUID.fastUUID().toString());
        resources.setAvailableChars(resources.getTotalChars());
        save(resources);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(AuthManage resources) {
        AuthManage authManage = getById(resources.getId());
        authManage.copy(resources);
        saveOrUpdate(authManage);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteAll(List<Integer> ids) {
        removeBatchByIds(ids);
    }

    @Override
    public void download(List<AuthManage> all, HttpServletResponse response) throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        for (AuthManage authManage : all) {
            Map<String,Object> map = new LinkedHashMap<>();
            map.put("授权码", authManage.getAuthCode());
            map.put("机器码", authManage.getMachineCode());
            map.put("失效时间", authManage.getExpiryDate());
            map.put("可用字符串", authManage.getAvailableChars());
            map.put("总字符数", authManage.getTotalChars());
            map.put("创建时间", authManage.getCreatedAt());
            map.put("修改时间", authManage.getUpdatedAt());
            map.put("状态", authManage.getStatus());
            map.put("备注", authManage.getRemarks());
            list.add(map);
        }
        FileUtil.downloadExcel(list, response);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AuthClientVo createTrial(String machineCode) {
        AuthManage authManage = new AuthManage();
        authManage.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        authManage.setStatus("1");
        //设置试用期3天
        Date currentDate = new Date();  // 获取当前日期
        Date expiryDate = DateUtil.offsetDay(currentDate, 3);  // 计算三天后的日期
        Timestamp timestamp = new Timestamp(expiryDate.getTime());  // 转换为 Timestamp
        authManage.setExpiryDate(timestamp);
        //设置翻译可用字符数
        authManage.setTotalChars(50000L);
        authManage.setAvailableChars(50000L);
        //生成授权码
        String authCode = UUID.fastUUID().toString();
        authManage.setAuthCode(authCode);
        authManage.setMachineCode(machineCode);
        create(authManage);
        AuthClientVo clientVo = new AuthClientVo();
        clientVo.setTimestamp(String.valueOf(System.currentTimeMillis()));
        clientVo.setMachineCode(machineCode);
        clientVo.setAuthCode(authCode);
        clientVo.setExpiryDate(String.valueOf(timestamp.getTime()));
        return clientVo;
    }

    @Override
    public AuthClientVo getAuthClient(String authCode) {
        LambdaQueryWrapper<AuthManage> lqw = new LambdaQueryWrapper<>();
        lqw.eq(AuthManage::getAuthCode, authCode);
        AuthManage authManage = getOne(lqw);
        if (authManage != null) {
            AuthClientVo clientVo = new AuthClientVo();
            clientVo.setTimestamp(String.valueOf(System.currentTimeMillis()));
            clientVo.setAuthCode(authCode);
            clientVo.setMachineCode(authManage.getMachineCode());
            clientVo.setExpiryDate(String.valueOf(authManage.getExpiryDate().getTime()));
            return clientVo;
        }
        return null;
    }

    @Override
    public AuthClientVo checkMachineCode(String machineCode) {
        LambdaQueryWrapper<AuthManage> lqw = new LambdaQueryWrapper<>();
        lqw.eq(AuthManage::getMachineCode, machineCode);
        AuthManage manage = getOne(lqw);
        if (manage != null) {
            AuthClientVo vo = new AuthClientVo();
            vo.setExpiryDate(String.valueOf(manage.getExpiryDate().getTime()));
            vo.setTimestamp(String.valueOf(System.currentTimeMillis()));
            vo.setMachineCode(machineCode);
            vo.setAuthCode(manage.getAuthCode());
            return vo;
        }
        return null;
    }

    @Override
    public AuthManage getAuthManageByAuthCode(String authCode) {
        LambdaQueryWrapper<AuthManage> lqw = new LambdaQueryWrapper<>();
        lqw.eq(AuthManage::getAuthCode, authCode);
        return getOne(lqw);
    }
}