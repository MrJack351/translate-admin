<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <label class="el-form-item-label">服务商</label>
        <el-select clearable @change="crud.toQuery" v-model="query.apiName" class="filter-item" filterable placeholder="请选择服务商">
          <el-option
            v-for="item in dict.provider_list"
            :key="item.id"
            :label="item.label"
            :value="item.value" />
        </el-select>
        <label class="el-form-item-label">系统编码</label>
        <el-input v-model="query.systemLanguageCode" clearable placeholder="系统编码" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <rrOperation :crud="crud" />
      </div>
      <!--如果想在工具栏加入更多按钮，可以使用插槽方式， slot = 'left' or 'right'-->
      <crudOperation :permission="permission" :show-export="false"/>
      <!--表单组件-->
      <el-dialog :close-on-click-modal="false" :before-close="crud.cancelCU" :visible.sync="crud.status.cu > 0" :title="crud.status.title" width="400px">
        <el-form ref="form" :model="form" :rules="rules" size="small" label-width="80px">
          <el-form-item label="服务商" prop="apiName">
            <el-select v-model="form.apiName" filterable placeholder="请选择">
              <el-option
                v-for="item in dict.provider_list"
                :key="item.id"
                :label="item.label"
                :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="系统编码" prop="systemLanguageCode">
            <el-input v-model="form.systemLanguageCode"  />
          </el-form-item>
          <el-form-item label="API编码" prop="apiLanguageCode">
            <el-input v-model="form.apiLanguageCode"  />
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button type="text" @click="crud.cancelCU">取消</el-button>
          <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
        </div>
      </el-dialog>
      <!--表格渲染-->
      <el-table ref="table" v-loading="crud.loading" :data="crud.data" size="small" style="width: 100%;" @selection-change="crud.selectionChangeHandler">
        <el-table-column type="selection" width="55" />
<!--        <el-table-column prop="id" label="id" />-->
        <el-table-column align="center" prop="apiName" label="服务商">
          <template slot-scope="scope">
            {{ dict.label.provider_list[scope.row.apiName] }}
          </template>
        </el-table-column>
        <el-table-column align="center" prop="systemLanguageCode" label="系统编码" />
        <el-table-column align="center" prop="apiLanguageCode" label="翻译商编码" />
        <el-table-column align="center" prop="createdAt" label="创建时间" />
        <el-table-column align="center" prop="updatedAt" label="修改时间" />
        <el-table-column v-if="checkPer(['admin','languageCodeMapping:edit','languageCodeMapping:del'])" label="操作" width="150px" align="center">
          <template slot-scope="scope">
            <udOperation
              :data="scope.row"
              :permission="permission"
            />
          </template>
        </el-table-column>
      </el-table>
      <!--分页组件-->
      <pagination />
    </div>
  </div>
</template>

<script>
import crudLanguageCodeMapping from '@/api/translate/languageCodeMapping'
import CRUD, { presenter, header, form, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'

const defaultForm = { id: null, systemLanguageCode: null, apiName: null, apiLanguageCode: null, createdAt: null, updatedAt: null }
export default {
  name: 'LanguageCodeMapping',
  components: { pagination, crudOperation, rrOperation, udOperation },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  dicts: ['provider_list'],
  cruds() {
    return CRUD({ title: '语言编码', url: 'api/languageCodeMapping', idField: 'id', sort: 'id,desc', crudMethod: { ...crudLanguageCodeMapping }})
  },
  data() {
    return {
      permission: {
        add: ['admin', 'languageCodeMapping:add'],
        edit: ['admin', 'languageCodeMapping:edit'],
        del: ['admin', 'languageCodeMapping:del']
      },
      rules: {
        systemLanguageCode: [
          { required: true, message: '系统编码不能为空', trigger: 'blur' }
        ],
        apiName: [
          { required: true, message: '服务商不能为空', trigger: 'blur' }
        ],
        apiLanguageCode: [
          { required: true, message: 'API编码不能为空', trigger: 'blur' }
        ]
      },
      queryTypeOptions: [
        { key: 'systemLanguageCode', display_name: '系统编码' },
        { key: 'apiName', display_name: '服务商' }
      ]
    }
  },
  methods: {
    // 钩子：在获取表格数据之前执行，false 则代表不获取数据
    [CRUD.HOOK.beforeRefresh]() {
      return true
    }
  }
}
</script>

<style scoped>

</style>
