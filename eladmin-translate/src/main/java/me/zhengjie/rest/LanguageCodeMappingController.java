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
import me.zhengjie.base.ApiResponse;
import me.zhengjie.domain.LanguageCodeMapping;
import me.zhengjie.domain.bo.LanguageMappingBo;
import me.zhengjie.service.LanguageCodeMappingService;
import me.zhengjie.domain.vo.LanguageCodeMappingQueryCriteria;
import lombok.RequiredArgsConstructor;
import java.util.List;

import me.zhengjie.utils.ApiResponseUtil;
import me.zhengjie.utils.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import io.swagger.annotations.*;
import java.io.IOException;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import me.zhengjie.utils.PageResult;

/**
* @author whh
* @date 2024-10-16
**/
@RestController
@RequiredArgsConstructor
@Api(tags = "语言编码管理")
@RequestMapping("/api/languageCodeMapping")
public class LanguageCodeMappingController {

    private final LanguageCodeMappingService languageCodeMappingService;

    @Log("根据系统编码查询数据")
    @ApiOperation("根据系统编码查询数据")
    @GetMapping(value = "/getLanguageMappingByCode")
    @PreAuthorize("@el.check('getLanguageMappingByCode:query')")
    public ApiResponse getLanguageMappingByCode(LanguageCodeMappingQueryCriteria criteria){
        String platform = criteria.getApiName();
        String code = criteria.getSystemLanguageCode();
        if (platform == null || StringUtils.isEmpty(platform)) {
            return ApiResponseUtil.error(-1,"参数有误");
        }
        if (code == null || StringUtils.isEmpty(code)) {
            return ApiResponseUtil.error(-1,"参数有误");
        }
        LanguageCodeMapping entity = languageCodeMappingService.getLanguageMappingByPlatform(platform,code);
        if (entity == null) {
            return ApiResponseUtil.error(-1,"未查询到数据");
        }
        return ApiResponseUtil.success(200,"success",entity);
    }

    @Log("修改多个平台编码")
    @ApiOperation("修改多个平台编码")
    @PostMapping(value = "/updateAllCode")
    @PreAuthorize("@el.check('updateAllCode:edit')")
    public ApiResponse updateAllCode(@RequestBody LanguageMappingBo mappingBo) {
        languageCodeMappingService.updateAllPlatformCode(mappingBo);
        // Your business logic here
        return ApiResponseUtil.success();
    }

    @Log("导出数据")
    @ApiOperation("导出数据")
    @GetMapping(value = "/download")
    @PreAuthorize("@el.check('languageCodeMapping:list')")
    public void exportLanguageCodeMapping(HttpServletResponse response, LanguageCodeMappingQueryCriteria criteria) throws IOException {
        languageCodeMappingService.download(languageCodeMappingService.queryAll(criteria), response);
    }

    @GetMapping
    @Log("查询语言编码")
    @ApiOperation("查询语言编码")
    @PreAuthorize("@el.check('languageCodeMapping:list')")
    public ResponseEntity<PageResult<LanguageCodeMapping>> queryLanguageCodeMapping(LanguageCodeMappingQueryCriteria criteria, Page<Object> page){
        return new ResponseEntity<>(languageCodeMappingService.queryAll(criteria,page),HttpStatus.OK);
    }

    @PostMapping
    @Log("新增语言编码")
    @ApiOperation("新增语言编码")
    @PreAuthorize("@el.check('languageCodeMapping:add')")
    public ResponseEntity<Object> createLanguageCodeMapping(@Validated @RequestBody LanguageCodeMapping resources){
        languageCodeMappingService.create(resources);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PutMapping
    @Log("修改语言编码")
    @ApiOperation("修改语言编码")
    @PreAuthorize("@el.check('languageCodeMapping:edit')")
    public ResponseEntity<Object> updateLanguageCodeMapping(@Validated @RequestBody LanguageCodeMapping resources){
        languageCodeMappingService.update(resources);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping
    @Log("删除语言编码")
    @ApiOperation("删除语言编码")
    @PreAuthorize("@el.check('languageCodeMapping:del')")
    public ResponseEntity<Object> deleteLanguageCodeMapping(@RequestBody List<Integer> ids) {
        languageCodeMappingService.deleteAll(ids);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}