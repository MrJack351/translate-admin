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
import me.zhengjie.domain.TranslationProviders;
import me.zhengjie.service.TranslationProvidersService;
import me.zhengjie.domain.vo.TranslationProvidersQueryCriteria;
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
* @date 2024-10-16
**/
@RestController
@RequiredArgsConstructor
@Api(tags = "服务提供商管理")
@RequestMapping("/api/translationProviders")
public class TranslationProvidersController {

    private final TranslationProvidersService translationProvidersService;

    @Log("导出数据")
    @ApiOperation("导出数据")
    @GetMapping(value = "/download")
    @PreAuthorize("@el.check('translationProviders:list')")
    public void exportTranslationProviders(HttpServletResponse response, TranslationProvidersQueryCriteria criteria) throws IOException {
        translationProvidersService.download(translationProvidersService.queryAll(criteria), response);
    }

    @GetMapping
    @Log("查询服务提供商")
    @ApiOperation("查询服务提供商")
    @PreAuthorize("@el.check('translationProviders:list')")
    public ResponseEntity<PageResult<TranslationProviders>> queryTranslationProviders(TranslationProvidersQueryCriteria criteria, Page<Object> page){
        return new ResponseEntity<>(translationProvidersService.queryAll(criteria,page),HttpStatus.OK);
    }

    @PostMapping
    @Log("新增服务提供商")
    @ApiOperation("新增服务提供商")
    @PreAuthorize("@el.check('translationProviders:add')")
    public ResponseEntity<Object> createTranslationProviders(@Validated @RequestBody TranslationProviders resources){
        translationProvidersService.create(resources);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PutMapping
    @Log("修改服务提供商")
    @ApiOperation("修改服务提供商")
    @PreAuthorize("@el.check('translationProviders:edit')")
    public ResponseEntity<Object> updateTranslationProviders(@Validated @RequestBody TranslationProviders resources){
        translationProvidersService.update(resources);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping
    @Log("删除服务提供商")
    @ApiOperation("删除服务提供商")
    @PreAuthorize("@el.check('translationProviders:del')")
    public ResponseEntity<Object> deleteTranslationProviders(@RequestBody List<Integer> ids) {
        translationProvidersService.deleteAll(ids);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}