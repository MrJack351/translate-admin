<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <label class="el-form-item-label">平台</label>
        <el-select clearable @change="crud.toQuery" v-model="query.platform" class="filter-item" filterable placeholder="翻译平台">
          <el-option
            v-for="item in dict.provider_list"
            :key="item.id"
            :label="item.label"
            :value="item.value" />
        </el-select>
        <label class="el-form-item-label">语言</label>
        <el-input v-model="query.language" clearable placeholder="语言" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <label class="el-form-item-label">状态</label>
        <el-select v-model="query.status" clearable placeholder="请选择状态" style="width: 185px;" class="filter-item" @change="crud.toQuery">
          <el-option label="成功" value="1"></el-option>
          <el-option label="失败" value="0"></el-option>
        </el-select>
        <label class="el-form-item-label">创建时间</label>
        <el-input v-model="query.createdAt" clearable placeholder="创建时间" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <rrOperation :crud="crud" />
      </div>
      <!--如果想在工具栏加入更多按钮，可以使用插槽方式， slot = 'left' or 'right'-->
      <crudOperation :permission="permission" :show-export="false"/>
      <!--表单组件-->
      <el-dialog :close-on-click-modal="false" :before-close="crud.cancelCU" :visible.sync="crud.status.cu > 0" :title="crud.status.title" width="500px">
        <el-form ref="form" :model="form" :rules="rules" size="small" label-width="80px">
          <el-form-item label="原文" prop="sourceText">
            <el-input v-model="form.sourceText" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="语言" prop="language">
            <el-input v-model="form.language" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="译文">
            <el-input v-model="form.translatedText" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="翻译平台" prop="platform">
            <el-input v-model="form.platform" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-select v-model="form.status" filterable placeholder="请选择">
              <el-option
                v-for="item in dict.translate_status"
                :key="item.id"
                :label="item.label"
                :value="item.value" />
            </el-select>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button type="text" @click="crud.cancelCU">取消</el-button>
          <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
        </div>
      </el-dialog>
      <!--表格渲染-->
      <el-table ref="table" v-loading="crud.loading" :data="crud.data" size="small" style="width: 100%;" @selection-change="crud.selectionChangeHandler">
        <el-table-column align="center" type="selection" width="55" />
<!--        <el-table-column prop="id" label="ID" />-->
        <el-table-column align="center" prop="authCode" label="授权码"/>
        <el-table-column align="center" prop="platform" label="翻译平台">
          <template slot-scope="scope">
            {{ dict.label.provider_list[scope.row.platform] }}
          </template>
        </el-table-column>
        <el-table-column align="center" prop="sourceText" label="原文" />
        <el-table-column align="center" prop="language" label="语言" />
        <el-table-column align="center" prop="translatedText" label="译文" />
        <el-table-column align="center" prop="status" label="状态">
          <template slot-scope="scope">
            <el-tag
              v-if="scope.row.status === '1'"
              type="success"
            >
              {{ dict.label.translate_status[scope.row.status] }}
            </el-tag>
            <el-tag
              v-else-if="scope.row.status === '0'"
              type="danger"
            >
              {{ dict.label.translate_status[scope.row.status] }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column align="center" prop="createdAt" label="创建时间" />
        <el-table-column align="center" prop="updatedAt" label="修改时间" />
        <el-table-column v-if="checkPer(['admin','messageCache:edit','messageCache:del'])" label="操作" width="150px" align="center">
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
import crudMessageCache from '@/api/translate/messageCache'
import CRUD, { presenter, header, form, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'

const defaultForm = { id: null, sourceText: null, language: null, translatedText: null, platform: null, status: null, createdAt: null, updatedAt: null }
export default {
  name: 'MessageCache',
  components: { pagination, crudOperation, rrOperation, udOperation },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  dicts: ['translate_status', 'provider_list'],
  cruds() {
    return CRUD({ title: '消息缓存', url: 'api/messageCache', idField: 'id', sort: 'id,desc', crudMethod: { ...crudMessageCache }})
  },
  data() {
    return {
      permission: {
        add: ['admin', 'messageCache:add'],
        edit: ['admin', 'messageCache:edit'],
        del: ['admin', 'messageCache:del']
      },
      rules: {
        sourceText: [
          { required: true, message: '原文不能为空', trigger: 'blur' }
        ],
        language: [
          { required: true, message: '语言不能为空', trigger: 'blur' }
        ],
        platform: [
          { required: true, message: '翻译平台不能为空', trigger: 'blur' }
        ],
        status: [
          { required: true, message: '状态不能为空', trigger: 'blur' }
        ]
      },
      queryTypeOptions: [
        { key: 'language', display_name: '语言' },
        { key: 'status', display_name: '状态' },
        { key: 'createdAt', display_name: '创建时间' }
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
