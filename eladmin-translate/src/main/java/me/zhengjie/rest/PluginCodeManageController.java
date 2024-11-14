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
import me.zhengjie.domain.PluginCodeManage;
import me.zhengjie.service.PluginCodeManageService;
import me.zhengjie.domain.vo.PluginCodeManageQueryCriteria;
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
* @date 2024-10-21
**/
@RestController
@RequiredArgsConstructor
@Api(tags = "插件代码管理")
@RequestMapping("/api/pluginCodeManage")
public class PluginCodeManageController {

    private final PluginCodeManageService pluginCodeManageService;

    @Log("导出数据")
    @ApiOperation("导出数据")
    @GetMapping(value = "/download")
    @PreAuthorize("@el.check('pluginCodeManage:list')")
    public void exportPluginCodeManage(HttpServletResponse response, PluginCodeManageQueryCriteria criteria) throws IOException {
        pluginCodeManageService.download(pluginCodeManageService.queryAll(criteria), response);
    }

    @GetMapping
    @Log("查询插件代码")
    @ApiOperation("查询插件代码")
    @PreAuthorize("@el.check('pluginCodeManage:list')")
    public ResponseEntity<PageResult<PluginCodeManage>> queryPluginCodeManage(PluginCodeManageQueryCriteria criteria, Page<Object> page){
        return new ResponseEntity<>(pluginCodeManageService.queryAll(criteria,page),HttpStatus.OK);
    }

    @PostMapping
    @Log("新增插件代码")
    @ApiOperation("新增插件代码")
    @PreAuthorize("@el.check('pluginCodeManage:add')")
    public ResponseEntity<Object> createPluginCodeManage(@Validated @RequestBody PluginCodeManage resources){
        pluginCodeManageService.create(resources);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PutMapping
    @Log("修改插件代码")
    @ApiOperation("修改插件代码")
    @PreAuthorize("@el.check('pluginCodeManage:edit')")
    public ResponseEntity<Object> updatePluginCodeManage(@Validated @RequestBody PluginCodeManage resources){
        pluginCodeManageService.update(resources);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping
    @Log("删除插件代码")
    @ApiOperation("删除插件代码")
    @PreAuthorize("@el.check('pluginCodeManage:del')")
    public ResponseEntity<Object> deletePluginCodeManage(@RequestBody List<Integer> ids) {
        pluginCodeManageService.deleteAll(ids);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}