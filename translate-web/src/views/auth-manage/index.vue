<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <label class="el-form-item-label">授权码</label>
        <el-input v-model="query.authCode" clearable placeholder="授权码" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <label class="el-form-item-label">机器码</label>
        <el-input v-model="query.machineCode" clearable placeholder="机器码" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
<!--        <label class="el-form-item-label">失效时间</label>-->
<!--        <el-input v-model="query.expiryDate" clearable placeholder="失效时间" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />-->
<!--        <label class="el-form-item-label">创建时间</label>-->
<!--        <el-input v-model="query.createdAt" clearable placeholder="创建时间" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />-->
        <label class="el-form-item-label">状态</label>
        <el-input v-model="query.status" clearable placeholder="状态" style="width: 185px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <rrOperation :crud="crud" />
      </div>
      <!--如果想在工具栏加入更多按钮，可以使用插槽方式， slot = 'left' or 'right'-->
      <crudOperation :permission="permission" :show-export="false"/>
      <!--表单组件-->
      <el-dialog :close-on-click-modal="false" :before-close="crud.cancelCU" :visible.sync="crud.status.cu > 0" :title="crud.status.title" width="500px">
        <el-form ref="form" :model="form" :rules="rules" size="small" label-width="80px">
          <el-form-item label="机器码" prop="machineCode">
            <el-input v-model="form.machineCode" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="总字符数" prop="totalChars">
            <el-input v-model="form.totalChars" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-select v-model="form.status" filterable placeholder="请选择">
              <el-option
                v-for="item in dict.enable_status"
                :key="item.id"
                :label="item.label"
                :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="失效时间" prop="expiryDate">
            <el-date-picker v-model="form.expiryDate" type="datetime" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="备注">
            <el-input v-model="form.remarks" :rows="3" type="textarea" style="width: 370px;" />
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
<!--        <el-table-column prop="id" label="ID" />-->
        <el-table-column align="center" :show-overflow-tooltip="true" prop="authCode" label="授权码" />
        <el-table-column align="center" :show-overflow-tooltip="true" prop="machineCode" label="机器码" />
        <el-table-column align="center" :show-overflow-tooltip="true" prop="expiryDate" label="失效时间" />
        <el-table-column align="center" :show-overflow-tooltip="true" prop="availableChars" label="可用字符串" />
        <el-table-column align="center" :show-overflow-tooltip="true" prop="totalChars" label="总字符数" />
        <el-table-column align="center" :show-overflow-tooltip="true" prop="status" label="状态">
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.status"
              active-value="1"
              inactive-value="0"
              @change="updateStatus(scope.row)"
            />
          </template>
        </el-table-column>
        <el-table-column align="center" :show-overflow-tooltip="true" prop="createdAt" label="创建时间" />
        <el-table-column align="center" :show-overflow-tooltip="true" prop="updatedAt" label="修改时间" />
        <el-table-column align="center" :show-overflow-tooltip="true" prop="remarks" label="备注" />
        <el-table-column v-if="checkPer(['admin','authManage:edit','authManage:del'])" label="操作" width="150px" align="center">
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
import crudAuthManage from '@/api/translate/authManage'
import CRUD, { presenter, header, form, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'

const defaultForm = { id: null, authCode: null, machineCode: null, expiryDate: null, availableChars: null, totalChars: null, createdAt: null, updatedAt: null, status: null, remarks: null }
export default {
  name: 'AuthManage',
  components: { pagination, crudOperation, rrOperation, udOperation },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  dicts: ['enable_status'],
  cruds() {
    return CRUD({ title: '设备授权', url: 'api/authManage', idField: 'id', sort: 'id,desc', crudMethod: { ...crudAuthManage }})
  },
  data() {
    return {
      permission: {
        add: ['admin', 'authManage:add'],
        edit: ['admin', 'authManage:edit'],
        del: ['admin', 'authManage:del']
      },
      rules: {
        expiryDate: [
          { required: true, message: '失效时间不能为空', trigger: 'blur' }
        ],
        totalChars: [
          { required: true, message: '总字符数不能为空', trigger: 'blur' }
        ],
        machineCode: [
          { required: true, message: '机器码不能为空', trigger: 'blur' }
        ],
        status: [
          { required: true, message: '状态不能为空', trigger: 'blur' }
        ]
      },
      queryTypeOptions: [
        { key: 'authCode', display_name: '授权码' },
        { key: 'machineCode', display_name: '机器码' },
        { key: 'expiryDate', display_name: '失效时间' },
        { key: 'createdAt', display_name: '创建时间' },
        { key: 'status', display_name: '状态' }
      ]
    }
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
      crudAuthManage.edit(row).then(() => {
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
