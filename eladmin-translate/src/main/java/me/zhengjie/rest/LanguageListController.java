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

import me.zhengjie.annotation.AnonymousAccess;
import me.zhengjie.annotation.Log;
import me.zhengjie.base.ApiResponse;
import me.zhengjie.domain.LanguageList;
import me.zhengjie.service.LanguageListService;
import me.zhengjie.domain.vo.LanguageListQueryCriteria;
import lombok.RequiredArgsConstructor;

import java.sql.Timestamp;
import java.util.List;

import me.zhengjie.utils.ApiResponseUtil;
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
* @date 2024-10-16
**/
@RestController
@RequiredArgsConstructor
@Api(tags = "语言列表管理")
@RequestMapping("/api/languageList")
public class LanguageListController {

    private final LanguageListService languageListService;

    @Log("导出数据")
    @ApiOperation("导出数据")
    @GetMapping(value = "/download")
    @PreAuthorize("@el.check('languageList:list')")
    public void exportLanguageList(HttpServletResponse response, LanguageListQueryCriteria criteria) throws IOException {
        languageListService.download(languageListService.queryAll(criteria), response);
    }

    @GetMapping
    @Log("查询语言列表")
    @ApiOperation("查询语言列表")
    @PreAuthorize("@el.check('languageList:list')")
    public ResponseEntity<PageResult<LanguageList>> queryLanguageList(LanguageListQueryCriteria criteria, Page<Object> page){
        return new ResponseEntity<>(languageListService.queryAll(criteria,page),HttpStatus.OK);
    }

    @PostMapping
    @Log("新增语言列表")
    @ApiOperation("新增语言列表")
    @PreAuthorize("@el.check('languageList:add')")
    public ResponseEntity<Object> createLanguageList(@Validated @RequestBody LanguageList resources){
        languageListService.create(resources);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PutMapping
    @Log("修改语言列表")
    @ApiOperation("修改语言列表")
    @PreAuthorize("@el.check('languageList:edit')")
    public ResponseEntity<Object> updateLanguageList(@Validated @RequestBody LanguageList resources){
        resources.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        languageListService.update(resources);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping
    @Log("删除语言列表")
    @ApiOperation("删除语言列表")
    @PreAuthorize("@el.check('languageList:del')")
    public ResponseEntity<Object> deleteLanguageList(@RequestBody List<Integer> ids) {
        languageListService.deleteAll(ids);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/languageList")
    @Log("获取所有语言列表")
    @ApiOperation("获取所有语言列表")
    @AnonymousAccess
    public ApiResponse queryLanguageList(){
        return ApiResponseUtil.success(200,"'success'",languageListService.selectAll());
    }
}