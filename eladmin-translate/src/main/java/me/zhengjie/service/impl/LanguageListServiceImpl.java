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
import me.zhengjie.domain.LanguageList;
import me.zhengjie.utils.FileUtil;
import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import me.zhengjie.service.LanguageListService;
import me.zhengjie.domain.vo.LanguageListQueryCriteria;
import me.zhengjie.mapper.LanguageListMapper;
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
public class LanguageListServiceImpl extends ServiceImpl<LanguageListMapper, LanguageList> implements LanguageListService {

    private final LanguageListMapper languageListMapper;

    @Override
    public PageResult<LanguageList> queryAll(LanguageListQueryCriteria criteria, Page<Object> page){
        return PageUtil.toPage(languageListMapper.findAll(criteria, page));
    }

    @Override
    public List<LanguageList> queryAll(LanguageListQueryCriteria criteria){
        return languageListMapper.findAll(criteria);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(LanguageList resources) {
        resources.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        save(resources);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(LanguageList resources) {
        LanguageList languageList = getById(resources.getId());
        languageList.copy(resources);
        saveOrUpdate(languageList);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteAll(List<Integer> ids) {
        removeBatchByIds(ids);
    }

    @Override
    public void download(List<LanguageList> all, HttpServletResponse response) throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        for (LanguageList languageList : all) {
            Map<String,Object> map = new LinkedHashMap<>();
            map.put("编码", languageList.getCode());
            map.put("语言", languageList.getName());
            map.put("显示名称", languageList.getDisplayName());
            map.put(" createdAt",  languageList.getCreatedAt());
            map.put(" updatedAt",  languageList.getUpdatedAt());
            list.add(map);
        }
        FileUtil.downloadExcel(list, response);
    }

    @Override
    public List<LanguageList> selectAll() {
        return languageListMapper.findAll();
    }

    @Override
    public LanguageList getLanguageByCode(String code) {
        LambdaQueryWrapper<LanguageList> lqw = new LambdaQueryWrapper<>();
        lqw.eq(LanguageList::getCode, code);
        return languageListMapper.selectOne(lqw);
    }
}