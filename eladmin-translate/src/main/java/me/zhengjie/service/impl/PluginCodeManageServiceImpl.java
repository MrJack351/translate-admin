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

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import me.zhengjie.domain.PluginCodeManage;
import me.zhengjie.exception.BadRequestException;
import me.zhengjie.utils.FileUtil;
import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import me.zhengjie.service.PluginCodeManageService;
import me.zhengjie.domain.vo.PluginCodeManageQueryCriteria;
import me.zhengjie.mapper.PluginCodeManageMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import me.zhengjie.utils.PageUtil;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import me.zhengjie.utils.PageResult;

/**
* @description 服务实现
* @author whh
* @date 2024-10-21
**/
@Service
@RequiredArgsConstructor
public class PluginCodeManageServiceImpl extends ServiceImpl<PluginCodeManageMapper, PluginCodeManage> implements PluginCodeManageService {

    private final PluginCodeManageMapper pluginCodeManageMapper;

    @Override
    public PageResult<PluginCodeManage> queryAll(PluginCodeManageQueryCriteria criteria, Page<Object> page){
        return PageUtil.toPage(pluginCodeManageMapper.findAll(criteria, page));
    }

    @Override
    public List<PluginCodeManage> queryAll(PluginCodeManageQueryCriteria criteria){
        return pluginCodeManageMapper.findAll(criteria);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(PluginCodeManage resources) {
        // 如果新插件的状态是启用状态
        if ("1".equals(resources.getStatus())) {
            // 查询该平台是否已有其他启用的插件
            LambdaQueryWrapper<PluginCodeManage> lqw = new LambdaQueryWrapper<>();
            lqw.eq(PluginCodeManage::getStatus, "1"); // 查询启用的插件
            lqw.eq(PluginCodeManage::getPlatformName, resources.getPlatformName()); // 查询同一平台的插件

            // 判断是否已经存在启用的插件
            PluginCodeManage existingPlugin = pluginCodeManageMapper.selectOne(lqw);
            if (existingPlugin != null) {
                throw new BadRequestException("该平台只能同时启用一个插件！");
            }
        }

        // 设置创建和更新时间
        resources.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        resources.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        // 保存插件信息
        save(resources);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(PluginCodeManage resources) {
        // 获取新状态
        String status = resources.getStatus();

        // 如果新状态是启用状态
        if ("1".equals(status)) {
            // 查询同一平台下是否已经有其他启用的插件，排除当前正在更新的插件
            LambdaQueryWrapper<PluginCodeManage> lqw = new LambdaQueryWrapper<>();
            lqw.eq(PluginCodeManage::getStatus, "1"); // 查询启用的插件
            lqw.eq(PluginCodeManage::getPlatformName, resources.getPlatformName()); // 查询同一平台的插件
            lqw.ne(PluginCodeManage::getId, resources.getId()); // 排除当前正在更新的插件

            // 如果已经存在其他启用的插件，则抛出异常
            if (pluginCodeManageMapper.selectList(lqw).size() > 0) {
                throw new BadRequestException("该平台只能同时启用一个插件！");
            }
        }

        // 设置更新时间
        resources.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        // 获取当前插件实例，并复制属性更新
        PluginCodeManage pluginCodeManage = getById(resources.getId());
        pluginCodeManage.copy(resources);

        // 保存或更新插件
        saveOrUpdate(pluginCodeManage);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteAll(List<Integer> ids) {
        removeBatchByIds(ids);
    }

    @Override
    public void download(List<PluginCodeManage> all, HttpServletResponse response) throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        for (PluginCodeManage pluginCodeManage : all) {
            Map<String,Object> map = new LinkedHashMap<>();
            map.put("平台名称", pluginCodeManage.getPlatformName());
            map.put("js代码", pluginCodeManage.getJsCode());
            map.put("创建时间", pluginCodeManage.getCreatedAt());
            map.put("修改时间", pluginCodeManage.getUpdatedAt());
            list.add(map);
        }
        FileUtil.downloadExcel(list, response);
    }

    @Override
    public PluginCodeManage getPluginCode(String platformName) {
        LambdaQueryWrapper<PluginCodeManage> lqw = new LambdaQueryWrapper<>();
        lqw.eq(PluginCodeManage::getPlatformName, platformName);
        lqw.eq(PluginCodeManage::getStatus, "1");
        return pluginCodeManageMapper.selectOne(lqw);
    }
}