<template>
  <div
    class="upload-cover"
    @click="showCoverSelect"
  >
    <div class="cover-wrap">
      <img
        ref="cover-image"
        class="cover-image"
        :src="value"
      >
    </div>
    <el-dialog
      title="选择封面"
      :visible.sync="dialogVisible"
      append-to-body
    >
      <el-tabs
        v-model="activeName"
        type="card"
      >
        <el-tab-pane
          label="素材库"
          name="first"
        >
          <!--
            ref 有两个作用
            1、作用到普通 HTML 标签上可以获取 DOM
            2、作用到组件上可以获取组件
           -->
          <image-list
            ref="image-list"
            :is-show-add="false"
            :is-show-action="false"
            is-show-selected
            :is-show-preview="false"
            :foo="666"
          />
        </el-tab-pane>
        <el-tab-pane
          label="上传图片"
          name="second"
        >
          <!-- <input
            ref="file"
            type="file"
            @change="onFileChange"
          >
          <img
            ref="preview-image"
            width="100"
          > -->
          <div class="upload_image">
            <el-upload
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
            <div style="margin:0 10px;color:#409eff">右侧为已上传的封面</div>
            <el-image
              style="width: 242px; height: 242px"
              :src="imageForm.url"
              fit="contain"
            >
              :preview-src-list="[scope.row.cover]" 快速包装成数组
              图片加载中的占位符
              <div
                slot="placeholder"
                class="image-slot"
              >
                加载中<span class="dot">...</span>
              </div>
              加载失败的占位符
              <div
                slot="error"
                class="image-slot"
              >
                <i class="el-icon-picture-outline" />
              </div>
            </el-image>
          </div>
        </el-tab-pane>
      </el-tabs>
      <span
        slot="footer"
        class="dialog-footer"
      >
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button
          type="primary"
          @click="onCoverConfirm"
        >确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
import { createImage } from '@/api/image'
import { getQnToken } from '@/api/article'
import ImageList from '@/views/admin/images/components/image-list'
export default {
  name: 'UploadCover',
  components: {
    ImageList
  },
  props: ['value'],
  // props: ['cover-image'],
  data () {
    return {
      dialogVisible: false,
      activeName: 'second',
      uploadForm: {
        token: '',
        key: ''
      },
      imageForm: {
        is_collected: false,
        url: ''
      }
    }
  },
  computed: {},
  watch: {},
  created () { },
  mounted () { },
  methods: {
    showCoverSelect () {
      // 展示选择封面的弹窗
      this.dialogVisible = true
    },
    onFileChange () {
      // 获取文件对象
      const file = this.$refs.file.files[0]
      // 图片预览
      const blob = window.URL.createObjectURL(file)
      this.$refs['preview-image'].src = blob
      // 防止用户选择同一个文件不触发 change 事件
      // this.$refs.file.value = ''
    },
    onCoverConfirm () {
      // 如果 tab 是上传图片，并且 input-file 有选择的文件，才执行上传图片的操作
      if (this.activeName === 'second') {
        const file = this.imageForm.url
        if (!file) {
          this.$message('请选择文件')
          return
        }
        // // 执行上传文件的操作
        // const fd = new FormData()
        // fd.append('image', file)
        // createImage(fd).then(res => {
        //   // 关闭弹出层
        //   this.dialogVisible = false
        // 展示上传的图片
        // this.$refs['cover-image'].src = res.data.data.url
        // 将图片地址发送给父组件
        this.dialogVisible = false
        this.$emit('input', this.imageForm.url)
        // this.$emit('update-cover', res.data.data.url)
        // })
      } else if (this.activeName === 'first') {
        // 还有一种组件通信方式：父组件可以直接访问子组件中的数据
        const imageList = this.$refs['image-list']
        const selected = imageList.selected
        if (selected === null) {
          this.$message('请选择封面图片')
          return
        }
        // 关闭对话框
        this.dialogVisible = false
        // 修改父组件绑定数据
        this.$emit('input', imageList.images[selected].url)
        // this.$emit('input', this.imageForm.url)
      }
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
      this.$message.success('上传成功!')
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
<style rel="stylesheet/scss" lang="scss" scoped>
.cover-wrap {
  width: 150px;
  height: 150px;
  border: 1px solid #000;
  .cover-image {
    height: 150px;
    max-width: 100%;
    object-fit: cover;
  }
}
.upload_image {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  .el-icon-picture-outline {
    font-size: 222px;
  }
}
</style>
