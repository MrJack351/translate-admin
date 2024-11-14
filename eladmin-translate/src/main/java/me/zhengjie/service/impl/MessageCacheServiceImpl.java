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

import me.zhengjie.domain.MessageCache;
import me.zhengjie.utils.FileUtil;
import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import me.zhengjie.service.MessageCacheService;
import me.zhengjie.domain.vo.MessageCacheQueryCriteria;
import me.zhengjie.mapper.MessageCacheMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import me.zhengjie.utils.PageUtil;
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
* @date 2024-10-18
**/
@Service
@RequiredArgsConstructor
public class MessageCacheServiceImpl extends ServiceImpl<MessageCacheMapper, MessageCache> implements MessageCacheService {

    private final MessageCacheMapper messageCacheMapper;

    @Override
    public PageResult<MessageCache> queryAll(MessageCacheQueryCriteria criteria, Page<Object> page){
        return PageUtil.toPage(messageCacheMapper.findAll(criteria, page));
    }

    @Override
    public List<MessageCache> queryAll(MessageCacheQueryCriteria criteria){
        return messageCacheMapper.findAll(criteria);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(MessageCache resources) {
        save(resources);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(MessageCache resources) {
        MessageCache messageCache = getById(resources.getId());
        messageCache.copy(resources);
        saveOrUpdate(messageCache);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteAll(List<Long> ids) {
        removeBatchByIds(ids);
    }

    @Override
    public void download(List<MessageCache> all, HttpServletResponse response) throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        for (MessageCache messageCache : all) {
            Map<String,Object> map = new LinkedHashMap<>();
            map.put("原文", messageCache.getSourceText());
            map.put("语言", messageCache.getLanguage());
            map.put("译文", messageCache.getTranslatedText());
            map.put("翻译平台", messageCache.getPlatform());
            map.put("状态", messageCache.getStatus());
            map.put("创建时间", messageCache.getCreatedAt());
            map.put("修改时间", messageCache.getUpdatedAt());
            list.add(map);
        }
        FileUtil.downloadExcel(list, response);
    }

    @Override
    public MessageCache getMessageCache(String sourceText, String language) {

        return messageCacheMapper.findMessageBySourceTextAndLanguage(sourceText, language);
    }

    @Override
    public void updateMessageCache(MessageCache messageCache) {
        messageCacheMapper.updateMessageCache(messageCache);
    }


}