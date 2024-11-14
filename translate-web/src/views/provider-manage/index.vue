<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <!--如果想在工具栏加入更多按钮，可以使用插槽方式， slot = 'left' or 'right'-->
      <crudOperation :permission="permission" :show-export="false"/>
      <!--表单组件-->
      <el-dialog :close-on-click-modal="false" :before-close="crud.cancelCU" :visible.sync="crud.status.cu > 0" :title="crud.status.title" width="500px">
        <el-form ref="form" :model="form" :rules="rules" size="small" label-width="80px">
          <el-form-item label="服务商" prop="providerName">
            <el-select v-model="form.providerName" filterable placeholder="请选择">
              <el-option
                v-for="item in dict.provider_list"
                :key="item.id"
                :label="item.label"
                :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="API Key" prop="apiKey">
            <el-input v-model="form.apiKey" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="API Url" prop="apiUrl">
            <el-input v-model="form.apiUrl" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="启用状态" prop="status">
            <el-select v-model="form.status" filterable placeholder="请选择">
              <el-option
                v-for="item in dict.provider_status"
                :key="item.id"
                :label="item.label"
                :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="附加参数">
            <el-input v-model="form.additionalConfig" :rows="3" type="textarea" style="width: 370px;" />
          </el-form-item>
<!--          <el-form-item label="语言列表">-->
<!--            <el-input v-model="form.supportedLanguages" :rows="3" type="textarea" style="width: 370px;" />-->
<!--          </el-form-item>-->
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button type="text" @click="crud.cancelCU">取消</el-button>
          <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
        </div>
      </el-dialog>
      <!--表格渲染-->
      <el-table ref="table" v-loading="crud.loading" :data="crud.data" size="small" style="width: 100%;" @selection-change="crud.selectionChangeHandler">
        <el-table-column type="selection" width="55" />
<!--        <el-table-column prop="id" label="主键" />-->
        <el-table-column align="center" prop="providerName" label="服务商">
          <template slot-scope="scope">
            {{ dict.label.provider_list[scope.row.providerName] }}
          </template>
        </el-table-column>
        <el-table-column align="center" prop="apiKey" label="API Key" />
        <el-table-column align="center" prop="apiUrl" label="API Url" />
        <el-table-column align="center" prop="status" label="启用状态">
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.status"
              active-value="1"
              inactive-value="0"
              @change="updateStatus(scope.row)"
            />
          </template>
        </el-table-column>
        <el-table-column align="center" prop="additionalConfig" label="附加参数" />
<!--        <el-table-column align="center" prop="supportedLanguages" label="语言列表" />-->
        <el-table-column align="center" prop="createdAt" label="创建时间" />
        <el-table-column align="center" prop="updatedAt" label="更新时间" />
        <el-table-column v-if="checkPer(['admin','translationProviders:edit','translationProviders:del'])" label="操作" width="150px" align="center">
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
import crudTranslationProviders from '@/api/translate/translationProviders'
import CRUD, { presenter, header, form, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'

const defaultForm = { id: null, providerName: null, apiKey: null, apiUrl: null, status: null, additionalConfig: null, supportedLanguages: null, createdAt: null, updatedAt: null }
export default {
  name: 'TranslationProviders',
  components: { pagination, crudOperation, rrOperation, udOperation },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  dicts: ['provider_status', 'provider_list'],
  cruds() {
    return CRUD({ title: '服务提供商', url: 'api/translationProviders', idField: 'id', sort: 'id,desc', crudMethod: { ...crudTranslationProviders }})
  },
  data() {
    return {
      permission: {
        add: ['admin', 'translationProviders:add'],
        edit: ['admin', 'translationProviders:edit'],
        del: ['admin', 'translationProviders:del']
      },
      rules: {
        id: [
          { required: true, message: '主键不能为空', trigger: 'blur' }
        ],
        providerName: [
          { required: true, message: '服务提供商不能为空', trigger: 'blur' }
        ],
        apiKey: [
          { required: true, message: 'API Key不能为空', trigger: 'blur' }
        ],
        apiUrl: [
          { required: true, message: 'API Url不能为空', trigger: 'blur' }
        ],
        status: [
          { required: true, message: '启用状态不能为空', trigger: 'blur' }
        ]
      }}
  },
  methods: {
    // 钩子：在获取表格数据之前执行，false 则代表不获取数据
    [CRUD.HOOK.beforeRefresh]() {
      return true
    },
    updateStatus(row) {
      // 构建更新的数据
      // const updatedData = {
      //   id: row.id,
      //   status: row.status
      // }
      // 调用 API 更新数据，假设 crudTranslationProviders.update 是更新方法
      crudTranslationProviders.edit(row).then(() => {
        this.$message.success('状态更新成功')
        // eslint-disable-next-line handle-callback-err
      }).catch((err) => {
        // 如果请求失败，将状态切换回原来的状态
        row.status = row.status === '1' ? '0' : '1'
        this.$message.error('状态更新失败')
      })
    }
  }
}
</script>

<style scoped>

</style>
