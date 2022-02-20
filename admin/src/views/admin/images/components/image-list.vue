<template>
  <div class="image-list">
    <div class="action-head">
      <el-radio-group
        v-model="collect"
        size="mini"
        @change="loadImages(1)"
      >
        <el-radio-button :label="false">全部</el-radio-button>
        <el-radio-button :label="true">收藏</el-radio-button>
      </el-radio-group>
      <el-button
        v-if="isShowAdd"
        size="mini"
        type="success"
        @click="dialogUploadVisible = true"
      >上传素材</el-button>
    </div>
    <!-- 素材列表 -->
    <el-row :gutter="10">
      <el-col
        v-for="(img, index) in images"
        :key="index"
        :xs="12"
        :sm="6"
        :md="6"
        :lg="4"
        class="image-item"
        @click.native="selected = index"
      >
        <!-- 如果是发表文章模式 则禁用预览 -->
        <el-image
          v-if="isShowPreview"
          style="height: 100px"
          :src="img.url"
          fit="cover"
          :preview-src-list="[img.url]"
        />
        <el-image
          v-else
          style="height: 100px"
          :src="img.url"
          fit="cover"
        />
        <div
          v-if="isShowSelected && selected === index"
          class="selected"
        />
        <div
          v-if="isShowAction"
          class="image-action"
        >
          <!--
            class 样式绑定
             {
                CSS类名: 布尔值
             }
             true：作用类名
             false：不作用类名
           -->
          <el-button
            type="warning"
            :icon="img.is_collected ? 'el-icon-star-on' : 'el-icon-star-off'"
            circle
            size="small"
            :loading="img.loading"
            @click="onCollect(img)"
          />
          <el-button
            size="small"
            type="danger"
            icon="el-icon-delete-solid"
            circle
            :loading="img.loading"
            @click="onDelete(img)"
          />
        </div>
      </el-col>
    </el-row>
    <!-- /素材列表 -->
    <!-- 数据分页 -->
    <!--
      分页数据改变以后，页码不会变化
      它需要单独处理高亮的页码
     -->
    <el-pagination
      background
      layout="prev, pager, next"
      :total="totalCount"
      :page-size="pageSize"
      :current-page.sync="page"
      @current-change="onPageChange"
    />
    <!-- /数据分页 -->
    <el-dialog
      title="上传素材"
      :visible.sync="dialogUploadVisible"
      :append-to-body="true"
    >
      <!--
        upload 组件本身就支持请求提交上传操作，说白了你使用它不用自己去发请求，它会自己发。
        请求方法：默认就是 POST
        请求路径：action，必须写完整路径
        请求头：headers
       -->
      <el-upload
        ref="uploadRef"
        class="upload-demo"
        drag
        action="http://up-z2.qiniu.com"
        :data="uploadForm"
        :limit="1"
        :show-file-list="false"
        :before-upload="beforeUpload"
        :on-error="uploadError"
        :on-success="uploadSuccess"
        :on-exceed="handleExceed"
      >
        <i
          class="el-icon-upload"
          style="color:#409eff"
        />
        <div class="el-upload__text"><em>点击上传</em>或则拖拽上传</div>
      </el-upload>
    </el-dialog>
  </div>
</template>
<script>
import { getImage, createImage, setSingleImage, deleteImage } from '@/api/image'
import { getQnToken } from '@/api/article'
export default {
  name: 'ImageList',
  components: {},
  // 使用对象的方式定义 prop，更严谨，功能更丰富，强烈建议在项目中使用
  // 参考文档：https://cn.vuejs.org/v2/guide/components-props.html#Prop-%E9%AA%8C%E8%AF%81
  props: {
    foo: {
      type: Number,
      // required: true,
      default: 123
    },
    // 是否显示添加素材
    isShowAdd: {
      type: Boolean, // 布尔值
      default: true // 默认值
    },
    // 是否显示图片下方的操作（收藏和删除）
    isShowAction: {
      type: Boolean,
      default: true
    },
    isShowSelected: {
      type: Boolean,
      default: false
    },
    isShowPreview: {
      type: Boolean, // 布尔值
      default: true // 默认值
    }
  },
  // 使用数组声明 prop，不建议，不够严谨，而且功能也不够强大，仅适合 demo 演示
  // props: ['dsadsadsa'],
  data () {
    const user = JSON.parse(window.localStorage.getItem('user'))
    return {
      imageForm: {
        is_collected: false,
        url: ''
      },
      uploadForm: {
        token: '',
        key: ''
      },
      collect: false, // 默认查询全部素材列表
      images: [], // 图片素材列表
      dialogUploadVisible: false,
      uploadHeaders: {
        Authorization: `Bearer ${user.token}`
      },
      totalCount: 0, // 总数据条数
      pageSize: 20, // 每页大小
      page: 1, // 当前页码
      selected: null // 选中的索引
    }
  },
  computed: {},
  watch: {
  },
  created () {
    // 页面初始化加载第 1 页数据
    this.loadImages(1)
  },
  mounted () { },
  methods: {
    loadImages (page = 1) {
      // 重置高亮页码，防止数据和页码不对应
      this.page = page
      getImage({
        collect: this.collect,
        page
      }).then(res => {
        console.log(res)
        const results = res.data.data.data
        results.forEach(img => {
          // img 对象本来没有 loading 数据
          // 我们这里收到的往里面添加该数据是用来控制每个收藏按钮的 loading 状态
          img.loading = false
        })
        this.images = results
        this.totalCount = res.data.data.meta.total
      })
    },
    onPageChange (page) {
      this.loadImages(page)
    },
    // 收藏与否
    onCollect (img) {
      // 展示 loading
      img.loading = true
      console.log(img.is_collected)
      setSingleImage({ id: img.id, is_collected: !img.is_collected }, img.id).then(res => {
        // 更新视图状态
        img.is_collected = !img.is_collected
        // 关闭 loading
        img.loading = false
      })
      // if (img.is_collected) {
      //   // 已收藏，取消收藏
      //   collectImage(img.id, false)
      // } else {
      //   // 没有收藏，添加收藏
      //   collectImage(img.id, true)
      // }
    },
    // 删除操作
    onDelete (img) {
      img.loading = true
      this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteImage(img.id).then(res => {
          // 重新加载数据列表
          this.loadImages(this.page)
          img.loading = false
          this.$message.success('删除成功!')
        })
      }).catch(() => {
        this.$message.info('取消删除!')
        img.loading = false
      })
    },
    // 上传前的钩子
    async beforeUpload (file) {
      const curr = this.$moment().format('YYYYMMDDHHmmss').toString()
      console.log(curr)
      const suffix = file.name
      console.log(file.name)
      this.uploadForm.key = curr + '_' + suffix
      console.log(this.uploadForm.key)
      const { data: res } = await getQnToken()
      this.uploadForm.token = res.data.token
    },
    // 图片上传完成后的狗子
    async uploadSuccess (res) {
      console.log('我是上传钩子', res)
      console.log(res)
      const url = `http://cdn.vologo.cn/${res.key}`
      console.log(url)
      this.imageForm.url = url
      const { data: response } = await createImage(this.imageForm)
      console.log(response)
      // 更新素材列表
      this.loadImages(this.page)
      this.$message.success('上传成功!')
      // 关闭对话框
      this.dialogUploadVisible = false
      this.$refs.uploadRef.clearFiles()
    },
    // 上传失败时的钩子
    uploadError (err) {
      // 解析七牛云返回的错误信息
      let myError = err.toString()// 转字符串
      myError = myError.replace('Error: ', '')// 去掉前面的
      myError = JSON.parse(myError)// 转对象
      console.log(myError)
      this.$message.error(`图片上传失败${myError.error}`)
    },
    // 限制上传一个的钩子
    handleExceed (files, fileList) {
      this.$message.warning('当前限制上传 1 个文件')
    }
  }
}
</script>
<style scoped rel="stylesheet/scss" lang="scss">
.action-head {
  padding-bottom: 20px;
  display: flex;
  justify-content: space-between;
}
.image-item {
  position: relative;
}
.image-action {
  font-size: 25px;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  color: #fff;
  height: 40px;
  background-color: rgba(204, 204, 204, 0.5);
  position: absolute;
  bottom: 4px;
  left: 5px;
  right: 5px;
}
.selected {
  background: url(./selected.png) no-repeat;
  background-size: cover;
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  top: 0;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
