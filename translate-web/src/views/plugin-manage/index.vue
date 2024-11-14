<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <label class="el-form-item-label">平台名称</label>
        <el-input v-model="query.platformName" clearable placeholder="平台名称" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <rrOperation :crud="crud" />
      </div>
      <!--如果想在工具栏加入更多按钮，可以使用插槽方式， slot = 'left' or 'right'-->
      <crudOperation :permission="permission" :show-export="false"/>
      <!--表单组件-->
      <el-dialog
        :close-on-click-modal="false"
        :before-close="crud.cancelCU"
        :visible.sync="crud.status.cu > 0"
        :title="crud.status.title"
        width="50%"
      >
        <el-form ref="form" :model="form" :rules="rules" size="small" label-width="100px">
          <!-- 平台名称 -->
          <el-form-item label="平台名称" prop="platformName">
            <el-select v-model="form.platformName" filterable placeholder="请选择" style="width: 100%;">
              <el-option
                v-for="item in dict.plugin_list"
                :key="item.id"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </el-form-item>

          <!-- 状态 -->
          <el-form-item label="状态" prop="status">
            <el-select v-model="form.status" filterable placeholder="请选择" style="width: 100%;">
              <el-option
                v-for="item in dict.enable_status"
                :key="item.id"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </el-form-item>

          <!-- 插件代码 -->
          <el-form-item label="插件代码" prop="jsCode">
            <code-editor v-model="form.jsCode" :options="editorOptions" />
          </el-form-item>
        </el-form>

        <!-- 操作按钮 -->
        <div slot="footer" class="dialog-footer">
          <el-button @click="crud.cancelCU">取消</el-button>
          <el-button type="primary" :loading="crud.status.cu === 2" @click="crud.submitCU">确认</el-button>
        </div>
      </el-dialog>
      <!--表格渲染-->
      <el-table ref="table" v-loading="crud.loading" :data="crud.data" size="small" style="width: 100%;" @selection-change="crud.selectionChangeHandler">
        <el-table-column type="selection" width="55" />
        <el-table-column align="center" prop="platformName" label="平台名称">
          <template slot-scope="scope">
            {{ dict.label.plugin_list[scope.row.platformName] }}
          </template>
        </el-table-column>
        <el-table-column align="center" :show-overflow-tooltip="true" prop="jsCode" label="插件代码" />
        <el-table-column prop="status" align="center" label="状态">
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.status"
              active-value="1"
              inactive-value="0"
              @change="updateStatus(scope.row)"
            />
          </template>
        </el-table-column>
        <el-table-column align="center" prop="createdAt" label="创建时间" />
        <el-table-column align="center" prop="updatedAt" label="修改时间" />
        <el-table-column v-if="checkPer(['admin','pluginCodeManage:edit','pluginCodeManage:del'])" label="操作" width="150px" align="center">
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
import crudPluginCodeManage from '@/api/translate/pluginCodeManage'
import CRUD, { presenter, header, form, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'
import 'codemirror/lib/codemirror.css'
import CodeEditor from './CodeMirror.vue'
const defaultForm = {id:null, platformName: null, jsCode: '', createdAt: null, updatedAt: null, status: null }
export default {
  name: 'PluginCodeManage',
  components: { pagination, crudOperation, rrOperation, udOperation, CodeEditor },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  dicts: ['plugin_list','enable_status'],
  cruds() {
    return CRUD({ title: '插件', url: 'api/pluginCodeManage', sort: 'desc', crudMethod: { ...crudPluginCodeManage }})
  },
  data() {
    return {
      editorOptions: {
        mode: 'javascript',
        lineNumbers: true,
        // lineWrapping: true,//自动换行
        theme: 'dracula',  // 使用深色主题
        extraKeys: {
          "Ctrl-Z": "undo",               // Ctrl+Z 撤销
          "Ctrl-Y": "redo",               // Ctrl+Y 恢复
          "Alt-F": "find"                 // Alt+F 触发查找功能
        }
      },
      permission: {
        add: ['admin', 'pluginCodeManage:add'],
        edit: ['admin', 'pluginCodeManage:edit'],
        del: ['admin', 'pluginCodeManage:del']
      },
      rules: {
        platformName: [
          { required: true, message: '平台名称不能为空', trigger: 'blur' }
        ],
        status: [
          { required: true, message: '状态不能为空', trigger: 'blur' }
        ]
      },
      queryTypeOptions: [
        { key: 'platformName', display_name: '平台名称' }
      ]
    }
  },
  methods: {
    // 钩子：在获取表格数据之前执行，false 则代表不获取数据
    [CRUD.HOOK.beforeRefresh]() {
      return true
    },
    updateStatus(row) {
      // 调用 API 更新数据，假设 crudTranslationProviders.update 是更新方法
      crudPluginCodeManage.edit(row).then(() => {
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
/* 优化代码编辑器的样式 */
.code-editor {
  height: 500px; /* 设定合适的高度 */
  margin-top: 10px;
}

.dialog-footer {
  text-align: right;
  padding: 10px 20px;
}
</style>
