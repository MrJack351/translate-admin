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
package me.zhengjie.service;

import me.zhengjie.domain.MessageCache;
import me.zhengjie.domain.vo.MessageCacheQueryCriteria;
import java.util.Map;
import java.util.List;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import me.zhengjie.utils.PageResult;

/**
* @description 服务接口
* @author whh
* @date 2024-10-18
**/
public interface MessageCacheService extends IService<MessageCache> {

    /**
    * 查询数据分页
    * @param criteria 条件
    * @param page 分页参数
    * @return PageResult
    */
    PageResult<MessageCache> queryAll(MessageCacheQueryCriteria criteria, Page<Object> page);

    /**
    * 查询所有数据不分页
    * @param criteria 条件参数
    * @return List<MessageCacheDto>
    */
    List<MessageCache> queryAll(MessageCacheQueryCriteria criteria);

    /**
    * 创建
    * @param resources /
    */
    void create(MessageCache resources);

    /**
    * 编辑
    * @param resources /
    */
    void update(MessageCache resources);

    /**
    * 多选删除
    * @param ids /
    */
    void deleteAll(List<Long> ids);

    /**
    * 导出数据
    * @param all 待导出的数据
    * @param response /
    * @throws IOException /
    */
    void download(List<MessageCache> all, HttpServletResponse response) throws IOException;

    MessageCache getMessageCache(String sourceText, String language);

    void updateMessageCache(MessageCache resources);
}