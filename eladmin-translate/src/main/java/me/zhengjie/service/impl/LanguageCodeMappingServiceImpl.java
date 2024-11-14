package me.zhengjie.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import me.zhengjie.domain.LanguageCodeMapping;
import me.zhengjie.domain.bo.LanguageMappingBo;
import me.zhengjie.utils.FileUtil;
import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import me.zhengjie.service.LanguageCodeMappingService;
import me.zhengjie.domain.vo.LanguageCodeMappingQueryCriteria;
import me.zhengjie.mapper.LanguageCodeMappingMapper;
import me.zhengjie.utils.StringUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import me.zhengjie.utils.PageUtil;

import java.sql.Timestamp;
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
 * @date 2024-10-16
 **/
@Service
@RequiredArgsConstructor
public class LanguageCodeMappingServiceImpl extends ServiceImpl<LanguageCodeMappingMapper, LanguageCodeMapping> implements LanguageCodeMappingService {

    private final LanguageCodeMappingMapper languageCodeMappingMapper;

    // 查询时缓存结果，使用apiName和systemLanguageCode作为缓存的key
    @Override
    @Cacheable(cacheNames = "languageCodeCache", key = "#apiName + ':' + #systemLanguageCode")
    public String getApiLanguageCode(String apiName, String systemLanguageCode) {
        LambdaQueryWrapper<LanguageCodeMapping> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(LanguageCodeMapping::getApiName, apiName)
                .eq(LanguageCodeMapping::getSystemLanguageCode, systemLanguageCode);
        // 查询数据库
        LanguageCodeMapping languageCodeMapping = languageCodeMappingMapper.selectOne(queryWrapper);
        if (languageCodeMapping != null) {
            return languageCodeMapping.getApiLanguageCode();
        } else {
            throw new RuntimeException("API Language Code not found for apiName: " + apiName + " and systemLanguageCode: " + systemLanguageCode);
        }
    }

    @Override
    public LanguageCodeMapping getLanguageMappingByPlatform(String platform,String code) {
        LambdaQueryWrapper<LanguageCodeMapping> lqw = new LambdaQueryWrapper<>();
        lqw.eq(LanguageCodeMapping::getApiName, platform);
        lqw.eq(LanguageCodeMapping::getSystemLanguageCode, code);
//        List<LanguageCodeMapping> list = list(lqw);
        return getOne(lqw);
    }

    //更新多个翻译服务平台的语言编码信息
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateAllPlatformCode(LanguageMappingBo mappingBo) {
        String sysTemLanguageCode = mappingBo.getLanguageCode();
        if (StringUtils.isEmpty(sysTemLanguageCode)) {
            return;
        }
        Map<String, String> platformCodes = mappingBo.getPlatformCodes();
        platformCodes.forEach((platform, apiLanguageCode) -> {
            try {
                if (!StringUtils.isEmpty(apiLanguageCode)) {
                    // 更新数据库
                    LambdaQueryWrapper<LanguageCodeMapping> lqw = new LambdaQueryWrapper<>();
                    lqw.eq(LanguageCodeMapping::getSystemLanguageCode, sysTemLanguageCode);
                    lqw.eq(LanguageCodeMapping::getApiName, platform);
                    //查询数据
                    LanguageCodeMapping entity = getOne(lqw);
                    if (entity != null) {
                        entity.setApiLanguageCode(apiLanguageCode);
                        update(entity);
                    } else {
                        entity = new LanguageCodeMapping();
                        entity.setApiLanguageCode(apiLanguageCode);
                        entity.setSystemLanguageCode(sysTemLanguageCode);
                        entity.setApiName(platform);
                        create(entity);
                    }
                }
            } catch (Exception e) {
                // 记录日志并继续处理其他平台
                log.error("更新所有平台的语言编码时发生错误:{}",e);
            }
        });
    }

    // 创建时清除缓存
    @Override
    @Transactional(rollbackFor = Exception.class)
    @CacheEvict(cacheNames = "languageCodeCache", allEntries = true)  // 清空所有缓存
    public void create(LanguageCodeMapping resources) {
        resources.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        save(resources);
    }

    // 更新时同步更新缓存
    @Override
    @Transactional(rollbackFor = Exception.class)
    @CachePut(cacheNames = "languageCodeCache", key = "#resources.apiName + ':' + #resources.systemLanguageCode")
    public void update(LanguageCodeMapping resources) {
        LanguageCodeMapping languageCodeMapping = getById(resources.getId());
        resources.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        languageCodeMapping.copy(resources);
        saveOrUpdate(languageCodeMapping);
    }

    // 删除时清除相关缓存条目
    @Override
    @Transactional(rollbackFor = Exception.class)
    @CacheEvict(cacheNames = "languageCodeCache", allEntries = true)  // 清空所有缓存或清除指定条目
    public void deleteAll(List<Integer> ids) {
        removeBatchByIds(ids);
    }

    // 下载
    @Override
    public void download(List<LanguageCodeMapping> all, HttpServletResponse response) throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        for (LanguageCodeMapping languageCodeMapping : all) {
            Map<String,Object> map = new LinkedHashMap<>();
            map.put("系统语言编码", languageCodeMapping.getSystemLanguageCode());
            map.put("服务商", languageCodeMapping.getApiName());
            map.put("API语言编码", languageCodeMapping.getApiLanguageCode());
            map.put("创建时间", languageCodeMapping.getCreatedAt());
            map.put("修改时间", languageCodeMapping.getUpdatedAt());
            list.add(map);
        }
        FileUtil.downloadExcel(list, response);
    }

    // 分页查询
    @Override
    public PageResult<LanguageCodeMapping> queryAll(LanguageCodeMappingQueryCriteria criteria, Page<Object> page){
        return PageUtil.toPage(languageCodeMappingMapper.findAll(criteria, page));
    }

    // 列表查询
    @Override
    public List<LanguageCodeMapping> queryAll(LanguageCodeMappingQueryCriteria criteria){
        return languageCodeMappingMapper.findAll(criteria);
    }
}