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

import me.zhengjie.annotation.Log;
import me.zhengjie.domain.MessageCache;
import me.zhengjie.service.MessageCacheService;
import me.zhengjie.domain.vo.MessageCacheQueryCriteria;
import lombok.RequiredArgsConstructor;
import java.util.List;
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
* @date 2024-10-18
**/
@RestController
@RequiredArgsConstructor
@Api(tags = "消息缓存管理")
@RequestMapping("/api/messageCache")
public class MessageCacheController {

    private final MessageCacheService messageCacheService;

    @Log("导出数据")
    @ApiOperation("导出数据")
    @GetMapping(value = "/download")
    @PreAuthorize("@el.check('messageCache:list')")
    public void exportMessageCache(HttpServletResponse response, MessageCacheQueryCriteria criteria) throws IOException {
        messageCacheService.download(messageCacheService.queryAll(criteria), response);
    }

    @GetMapping
    @Log("查询消息缓存")
    @ApiOperation("查询消息缓存")
    @PreAuthorize("@el.check('messageCache:list')")
    public ResponseEntity<PageResult<MessageCache>> queryMessageCache(MessageCacheQueryCriteria criteria, Page<Object> page){
        return new ResponseEntity<>(messageCacheService.queryAll(criteria,page),HttpStatus.OK);
    }

    @PostMapping
    @Log("新增消息缓存")
    @ApiOperation("新增消息缓存")
    @PreAuthorize("@el.check('messageCache:add')")
    public ResponseEntity<Object> createMessageCache(@Validated @RequestBody MessageCache resources){
        messageCacheService.create(resources);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PutMapping
    @Log("修改消息缓存")
    @ApiOperation("修改消息缓存")
    @PreAuthorize("@el.check('messageCache:edit')")
    public ResponseEntity<Object> updateMessageCache(@Validated @RequestBody MessageCache resources){
        messageCacheService.update(resources);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping
    @Log("删除消息缓存")
    @ApiOperation("删除消息缓存")
    @PreAuthorize("@el.check('messageCache:del')")
    public ResponseEntity<Object> deleteMessageCache(@RequestBody List<Long> ids) {
        messageCacheService.deleteAll(ids);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}