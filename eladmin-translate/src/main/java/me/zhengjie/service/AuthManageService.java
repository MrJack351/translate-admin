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

import me.zhengjie.domain.AuthManage;
import me.zhengjie.domain.vo.AuthClientVo;
import me.zhengjie.domain.vo.AuthManageQueryCriteria;
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
* @date 2024-10-19
**/
public interface AuthManageService extends IService<AuthManage> {

    /**
    * 查询数据分页
    * @param criteria 条件
    * @param page 分页参数
    * @return PageResult
    */
    PageResult<AuthManage> queryAll(AuthManageQueryCriteria criteria, Page<Object> page);

    /**
    * 查询所有数据不分页
    * @param criteria 条件参数
    * @return List<AuthManageDto>
    */
    List<AuthManage> queryAll(AuthManageQueryCriteria criteria);

    /**
    * 创建
    * @param resources /
    */
    void create(AuthManage resources);

    /**
    * 编辑
    * @param resources /
    */
    void update(AuthManage resources);

    /**
    * 多选删除
    * @param ids /
    */
    void deleteAll(List<Integer> ids);

    /**
    * 导出数据
    * @param all 待导出的数据
    * @param response /
    * @throws IOException /
    */
    void download(List<AuthManage> all, HttpServletResponse response) throws IOException;

    //根据机器码创建试用账号
    AuthClientVo createTrial(String machineCode);

    //根据授权码查询账号信息
    AuthClientVo getAuthClient(String authCode);

    AuthClientVo checkMachineCode(String machineCode);

    AuthManage getAuthManageByAuthCode(String authCode);
}