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

import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import me.zhengjie.domain.TranslationProviders;
import me.zhengjie.utils.FileUtil;
import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import me.zhengjie.service.TranslationProvidersService;
import me.zhengjie.domain.vo.TranslationProvidersQueryCriteria;
import me.zhengjie.mapper.TranslationProvidersMapper;
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
* @date 2024-10-16
**/
@Service
@RequiredArgsConstructor
public class TranslationProvidersServiceImpl extends ServiceImpl<TranslationProvidersMapper, TranslationProviders> implements TranslationProvidersService {

    private final TranslationProvidersMapper translationProvidersMapper;

    @Override
    public PageResult<TranslationProviders> queryAll(TranslationProvidersQueryCriteria criteria, Page<Object> page){
        return PageUtil.toPage(translationProvidersMapper.findAll(criteria, page));
    }

    @Override
    public List<TranslationProviders> queryAll(TranslationProvidersQueryCriteria criteria){
        return translationProvidersMapper.findAll(criteria);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(TranslationProviders resources) {
        save(resources);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(TranslationProviders resources) {
        TranslationProviders translationProviders = getById(resources.getId());
        resources.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        translationProviders.copy(resources);
        saveOrUpdate(translationProviders);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteAll(List<Integer> ids) {
        removeBatchByIds(ids);
    }

    @Override
    public void download(List<TranslationProviders> all, HttpServletResponse response) throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        for (TranslationProviders translationProviders : all) {
            Map<String,Object> map = new LinkedHashMap<>();
            map.put("服务提供商", translationProviders.getProviderName());
            map.put("API Key", translationProviders.getApiKey());
            map.put("API Url", translationProviders.getApiUrl());
            map.put("启用状态", translationProviders.getStatus());
            map.put("附加配置信息(headers或特定参数)", translationProviders.getAdditionalConfig());
            map.put("语言列表", translationProviders.getSupportedLanguages());
            map.put("创建时间", translationProviders.getCreatedAt());
            map.put("更新时间", translationProviders.getUpdatedAt());
            list.add(map);
        }
        FileUtil.downloadExcel(list, response);
    }

    @Override
    public TranslationProviders getProviderConfig(String providerName) {
        // 查询所有符合条件的记录
        List<TranslationProviders> providers = new LambdaQueryChainWrapper<>(translationProvidersMapper)
                .eq(TranslationProviders::getProviderName, providerName) // 条件查询：providerName 匹配
                .eq(TranslationProviders::getStatus, 1)                  // 条件查询：status = 1 (启用)
                .list();  // 返回符合条件的所有记录

        // 如果查询到的结果为空，直接返回 null
        if (providers == null || providers.isEmpty()) {
            return null;
        }
        // 如果有多条记录，则随机返回其中一条
        if (providers.size() > 1) {
            Random random = new Random();
            int randomIndex = random.nextInt(providers.size());  // 随机获取一个索引
            return providers.get(randomIndex);  // 返回随机挑选的记录
        }
        // 如果只有一条记录，直接返回
        return providers.get(0);
    }
}