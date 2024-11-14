<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <label class="el-form-item-label">编码</label>
        <el-input v-model="query.code" clearable placeholder="编码" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <label class="el-form-item-label">语言名称</label>
        <el-input v-model="query.displayName" clearable placeholder="显示名称" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <rrOperation :crud="crud" />
      </div>
      <!--如果想在工具栏加入更多按钮，可以使用插槽方式， slot = 'left' or 'right'-->
      <crudOperation :permission="permission" :show-export="false"/>
      <!--表单组件-->
      <el-dialog :close-on-click-modal="false" :before-close="crud.cancelCU" :visible.sync="crud.status.cu > 0" :title="crud.status.title" width="500px">
        <el-form ref="form" :model="form" :rules="rules" size="small" label-width="80px">
          <el-form-item label="编码" prop="code">
            <el-input v-model="form.code" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="中文名称" prop="displayName">
            <el-input v-model="form.displayName" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="English" prop="name">
            <el-input v-model="form.name" style="width: 370px;" />
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button type="text" @click="crud.cancelCU">取消</el-button>
          <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
        </div>
      </el-dialog>
      <!-- 配置对话框 -->
      <el-dialog title="配置平台编码" :visible.sync="showConfigDialog" width="500px">
        <!-- 提示区域 -->
        <el-alert
          title=""
          type="info"
          effect="light"
          :closable="false"
          :description="`编码: ${currentLanguage.code} | 名称: ${currentLanguage.displayName}`"
          style="font-weight: bold"
        />
        <!-- 表单区域 -->
        <el-form :model="platformConfigForm">
          <el-form-item
            v-for="platform in dict.provider_list"
            :key="platform.id"
            :label="platform.label"
          >
            <el-input
              v-model="platformConfigForm[platform.value]"
              :placeholder="'请输入' + platform.label + '的编码'"
            ></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="showConfigDialog = false">取消</el-button>
          <el-button type="primary" :loading="loadingBth" @click="submitPlatformConfig">确认</el-button>
        </span>
      </el-dialog>
      <!--表格渲染-->
      <el-table ref="table" v-loading="crud.loading" :data="crud.data" size="small" style="width: 100%;" @selection-change="crud.selectionChangeHandler">
        <el-table-column type="selection" width="55" />
<!--        <el-table-column prop="id" label="id" />-->
        <el-table-column align="center" prop="code" label="编码" />
        <el-table-column align="center" prop="displayName" label="中文名称" />
        <el-table-column align="center" prop="name" label="English" />
        <el-table-column align="center" prop="createdAt" label="创建时间" />
<!--        <el-table-column align="center" prop="updatedAt" label="修改时间" />-->
        <el-table-column v-if="checkPer(['admin','languageList:edit','languageList:del'])" label="操作" fixed="right" width="200px" align="center">
          <template slot-scope="scope">
            <el-button type="success" size="mini" icon="el-icon-s-tools" @click="openConfigDialog(scope.row)"></el-button>
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
import crudLanguageList from '@/api/translate/languageList'
import { getLanguageMappingByCode, updateAllCode } from '@/api/translate/languageCodeMapping'
import CRUD, { presenter, header, form, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'
import { error } from 'autoprefixer/lib/utils'

const defaultForm = { id: null, code: null, name: null, displayName: null, createdAt: null, updatedAt: null }
export default {
  name: 'LanguageList',
  components: { pagination, crudOperation, rrOperation, udOperation },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  dicts: ['provider_list'],
  cruds() {
    return CRUD({ title: '语言列表', url: 'api/languageList', idField: 'id', sort: 'id,desc', crudMethod: { ...crudLanguageList }})
  },
  data() {
    return {
      loadingBth: false,
      showConfigDialog: false,
      currentLanguage: {},
      platformConfigForm: {},
      platformList: [],
      permission: {
        add: ['admin', 'languageList:add'],
        edit: ['admin', 'languageList:edit'],
        del: ['admin', 'languageList:del']
      },
      rules: {
        code: [
          { required: true, message: '编码不能为空', trigger: 'blur' }
        ],
        name: [
          { required: true, message: '语言不能为空', trigger: 'blur' }
        ],
        displayName: [
          { required: true, message: '显示名称不能为空', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    // 钩子：在获取表格数据之前执行，false 则代表不获取数据
    [CRUD.HOOK.beforeRefresh]() {
      return true
    },
    // 打开配置对话框并初始化表单
    openConfigDialog(row) {
      this.currentLanguage = row
      this.platformConfigForm = {}
      this.dict.provider_list.forEach(platform => {
        const params = { apiName: platform.value, systemLanguageCode: row.code }
        getLanguageMappingByCode(params)
          .then(res => {
            if (res.code === -1) {
              // this.$message.info(`${res.msg}:${platform.label}`)
              this.$set(this.platformConfigForm, platform.value, '')
            }
            if (res.code === 200) {
              this.$set(this.platformConfigForm, platform.value, res.data.apiLanguageCode)
            }
          })
          .catch(error => {
            // 显示用户友好的提示
            this.$message.error(`获取${platform.value}编码时发生错误${error}`)
          })
        // this.$set(this.platformConfigForm, platform.value, '')
      })
      this.showConfigDialog = true
    },

    // 提交平台配置
    submitPlatformConfig() {
      this.loadingBth = true
      const data = {
        languageCode: this.currentLanguage.code,
        platformCodes: this.platformConfigForm
      }
      updateAllCode(data).then(res => {
        if (res.code === 200) {
          this.$message.success(`${res.msg}`)
          this.loadingBth = false
          this.showConfigDialog = false
        } else {
          this.$message.success(`${res.msg}`)
          this.loadingBth = false
        }
      }).catch(error => {
        // 显示用户友好的提示
        this.$message.error(`发生错误${error}`)
        this.loadingBth = false
        this.showConfigDialog = false
      })
    }
  }
}
</script>

<style scoped>

</style>
