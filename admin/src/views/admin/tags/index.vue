<template>
  <div class="">
    <el-card class="box-card">
      <div
        slot="header"
        class="clearfix"
      >
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/admin' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item>标签管理</el-breadcrumb-item>
        </el-breadcrumb>
      </div>
      <div>
        <el-button
          type="primary"
          style="margin-bottom:20px"
          icon="el-icon-circle-plus"
          @click="addTagDialog = true"
        >新增标签</el-button>
      </div>
      <el-table
        :data="tagList.filter(data => !search || data.name.toLowerCase().includes(search.toLowerCase()))"
        stripe
        style="width: 100%"
      >
        <el-table-column
          prop="id"
          label="ID号"
          fit
          sortable
        />
        <el-table-column
          prop="name"
          label="标签名称"
          fit
          sortable
        />
        <el-table-column
          prop="key"
          label="标签关键词"
          fit
          sortable
        />
        <el-table-column
          prop="color"
          label="标签颜色"
          fit
          sortable
        >
          <template slot-scope="scope">
            {{ scope.row.color }}
            <el-tag
              :color="scope.row.color"
              width="50px"
            />
          </template>
        </el-table-column>
        <el-table-column
          align="right"
          width="180"
        >
          <template
            slot="header"
            slot-scope="scope"
          >
            <el-input
              v-model="search"
              size="mini"
              placeholder="标题搜索"
              @click="handleSearch(scope)"
            />
          </template>
          <template slot-scope="scope">
            <el-button
              type="primary"
              icon="el-icon-edit"
              size="mini"
              @click="handleEdit(scope.row.id, scope.row)"
            >编辑</el-button>
            <el-button
              icon="el-icon-delete"
              size="mini"
              type="danger"
              @click="handleDelete(scope.row.id, scope.row)"
            >删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- 新增弹窗 -->
    <el-dialog
      title="新增标签"
      :visible.sync="addTagDialog"
      width="50%"
      @close="addClose"
    >
      <el-form
        ref="addFormRef"
        label-width="100px"
        :model="addForm"
        :rules="addRules"
      >
        <el-form-item
          label="标签名称"
          prop="name"
        >
          <el-input v-model="addForm.name" />
        </el-form-item>
        <el-form-item
          label="分离关键字"
          prop="key"
        >
          <el-input v-model="addForm.key" />
        </el-form-item>
        <el-form-item
          label="标签颜色"
          prop="color"
        >
          <el-select
            v-model="addForm.color"
            placeholder="请选择"
          >
            <el-option
              v-for="item in colors"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
              <span style="float: left">{{ item.label }}</span>
              <span :style="{float: floatRight, color: item.value}">{{ item.value }}</span>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item style="text-align: right;">
          <el-button @click="addTagDialog = false">取 消</el-button>
          <el-button
            type="primary"
            @click="addTag"
          >确 定</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
    <!-- 编辑弹窗 -->
    <el-dialog
      title="编辑标签"
      :visible.sync="editTagDialog"
      width="50%"
      @close="editClose"
    >
      <el-form
        ref="editFormRef"
        label-width="100px"
        :model="editForm"
        :rules="editRules"
      >
        <el-form-item
          label="标签名称"
          prop="name"
        >
          <el-input v-model="editForm.name" />
        </el-form-item>
        <el-form-item
          label="分离关键字"
          prop="key"
        >
          <el-input v-model="editForm.key" />
        </el-form-item>
        <el-form-item
          label="标签颜色"
          prop="color"
        >
          <el-input v-model="editForm.color" />
        </el-form-item>
        <el-form-item style="text-align: right;">
          <el-button @click="editTagDialog = false">取 消</el-button>
          <el-button
            type="primary"
            @click="editTag"
          >确 定</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>
<script>
import { getTag, createTag, deleteTag, getSingleTag, setSingleTag } from '@/api/tag'
import { mapState, mapActions } from 'vuex'
export default {
  name: 'Tagies',
  components: {},
  props: {},
  data () {
    return {
      search: '',
      // tagList: [],
      addTagDialog: false,
      editTagDialog: false,
      floatRight: 'right',
      updataId: -1,
      addForm: {
        name: '',
        key: '',
        color: ''
      },
      editForm: {
        name: '',
        key: '',
        color: 0
      },
      addRules: {
        name: [
          { required: true, message: '请输入标签名称', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ], key: [
          { required: true, message: '请输入标签关键字', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ], color: [
          { required: true, message: '请选择标签颜色', trigger: 'blur' }
        ]
      },
      editRules: {
        name: [
          { required: true, message: '请输入标签名称', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ], key: [
          { required: true, message: '请输入标签关键字', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ], color: [
          { required: true, message: '请选择标签颜色', trigger: 'blur' }
        ]
      },
      colors: [{
        value: 'red',
        label: '红色'
      }, {
        value: 'green',
        label: '绿色'
      }, {
        value: 'black',
        label: '黑色'
      }, {
        value: 'yellow',
        label: '黄色'
      }, {
        value: 'blue',
        label: '蓝色'
      }, {
        value: 'brown',
        label: '棕色'
      }, {
        value: 'silver',
        label: '银色'
      }, {
        value: 'gold',
        label: '金色'
      }, {
        value: 'coral',
        label: '珊瑚色'
      }, {
        value: 'purple',
        label: '紫色'
      }, {
        value: 'pink',
        label: '粉色'
      }, {
        value: 'cyan',
        label: '青色'
      }, {
        value: 'orange',
        label: '橙色'
      }
      ]
    }
  },
  computed: {
    ...mapState('tag', ['tagList'])
  },
  watch: {},
  created () {
    // 请求首屏数据
    this.LoadTag()
  },
  mounted () {
  },
  methods: {
    // 首屏数据请求 所有的标签
    // async LoadTag () {
    //   const { data: res } = await getTag()
    //   this.tagList = res.data
    // },
    ...mapActions('tag', ['LoadTag']),
    // 获取所编辑的标签数据
    async handleEdit (id, row) {
      this.editTagDialog = true
      const { data: res } = await getSingleTag(id)
      this.editForm = res.data
      this.updataId = res.data.id
      console.log(this.updataId)
    },
    // 删除标签
    handleDelete (index, row) {
      this.$confirm('此操作将永久删除该标签, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        const { data: res } = await deleteTag(index)
        console.log(res)
        this.$message.success(res.msg)
        this.LoadTag()
      }).catch(() => {
        this.$message.info('已取消删除')
      })
    },
    // 初始化添加的对话框
    addClose () {
      this.$refs.addFormRef.resetFields()
    },
    // 添加标签请求
    addTag () {
      this.$refs['addFormRef'].validate(async valid => {
        if (!valid) return this.$message.error('新增信息不正确，重新填写')
        const { data: res } = await createTag(this.addForm)
        this.$message.success(res.data.msg)
        this.LoadTag()
        this.addTagDialog = false
      })
    },
    // 初始化编辑对话框
    editClose () {
      this.$refs.editFormRef.resetFields()
    },
    // 编辑标签请求
    editTag () {
      this.$refs['editFormRef'].validate(async valid => {
        if (!valid) return this.$message.error('编辑的信息不正确，重新填写')
        delete this.editForm.id
        const { data: res } = await setSingleTag(this.editForm, this.updataId)
        console.log(res)
        this.$message.success(res.msg)
        this.LoadTag()
        this.editTagDialog = false
      })
    },
    handleSearch (scope) {
      console.log(scope)
    }
  }
}
</script>
<style rel="stylesheet/scss" lang="scss" scoped>
.has-gutter {
  background: #fafafa;
}
</style>
