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
package me.zhengjie.mapper;

import me.zhengjie.domain.MessageCache;
import me.zhengjie.domain.vo.MessageCacheQueryCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
* @author whh
* @date 2024-10-18
**/
@Mapper
public interface MessageCacheMapper extends BaseMapper<MessageCache> {

    IPage<MessageCache> findAll(@Param("criteria") MessageCacheQueryCriteria criteria, Page<Object> page);

    List<MessageCache> findAll(@Param("criteria") MessageCacheQueryCriteria criteria);

    MessageCache findMessageBySourceTextAndLanguage(String sourceText, String language);

    void updateMessageCache(@Param("messageCache") MessageCache messageCache);

}