<template>
  <div class="">
    <el-card class="box-card">
      <div
        slot="header"
        class="clearfix"
      >
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/admin' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item>关于我</el-breadcrumb-item>
        </el-breadcrumb>
      </div>
      <el-form
        ref="aboutFormRef"
        :model="aboutForm"
        :rules="aboutRules"
        label-width="120px"
      >
        <el-form-item
          label="上传头像"
          prop="avatar"
        >
          <upload-cover v-model="aboutForm.avatar" />
        </el-form-item>
        <el-form-item
          label="昵称"
          prop="nickname"
        >
          <el-input v-model="aboutForm.nickname" />
        </el-form-item>
        <el-form-item
          label="GitHub"
          prop="github"
        >
          <el-input v-model="aboutForm.github" />
        </el-form-item>
        <el-form-item
          label="qq号"
          prop="qq"
        >
          <el-input v-model="aboutForm.qq" />
        </el-form-item>
        <el-form-item
          label="微信号"
          prop="wechat"
        >
          <el-input v-model="aboutForm.wechat" />
        </el-form-item>
        <el-form-item
          label="哔哩哔哩"
          prop="bilibili"
        >
          <el-input v-model="aboutForm.bilibili" />
        </el-form-item>
        <el-form-item
          label="网易ID号"
          prop="netease"
        >
          <el-input v-model="aboutForm.netease" />
        </el-form-item>
        <el-form-item
          label="电子邮箱"
          prop="email"
        >
          <el-input v-model="aboutForm.email" />
        </el-form-item>
        <el-form-item
          label="上传二维码"
          prop="reward"
        >
          <upload-cover v-model="aboutForm.reward" />
        </el-form-item>
        <el-form-item
          label="内容"
          prop="introduction"
        >
          <mavon-editor
            ref="md"
            v-model="aboutForm.introduction"
            style="min-height: 600px"
            placeholder="write something"
            @imgAdd="$imgAdd"
          />
        </el-form-item>
        <el-form-item>
          <el-button
            type="primary"
            :loading="loading"
            @click="publishAbout"
          >保存</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<script>
import { createAbout, getSingleAbout, setSingleAbout } from '@/api/about'
import { getQnToken } from '@/api/article'
import UploadCover from './components/upload-cover'
import { createImage } from '@/api/image'
import { mavonEditor } from 'mavon-editor'
// import { getUploadToken } from '../../../utils/upload'
import 'mavon-editor/dist/css/index.css'
import axios from 'axios'
export default {
  name: 'About',
  components: {
    'mavon-editor': mavonEditor,
    UploadCover
  },
  props: {},
  data () {
    return {
      loading: false,
      uploadURL: '#',
      dialogImageUrl: '',
      dialogVisible: false,
      qnToken: '',
      newFileName: '',
      uploadForm: {
        token: '',
        key: ''
      },
      imageForm: {
        is_collected: false,
        url: ''
      },
      aboutForm: {
        avatar: '',
        nickname: '',
        github: '',
        qq: '',
        wechat: '',
        bilibili: '',
        netease: '',
        email: '',
        reward: '',
        // eslint-disable-next-line
        introduction: "# Markdown Demo(Ctrl + A 删除即可)  \n\n- - -\n\n## 一、标题\n\n### 1. 使用 `#` 表示标题，其中 `#` 号必须在行首，例如：  \n\n# 一号标题\n## 二号标题\n### 三号标题\n#### 四号标题\n##### 五号标题\n###### 六号标题\n\n### 2. 使用 `===` 或者 `---` 表示，例如：  \n\n一级标题\n===\n\n二级标题\n---\n\n#### **扩展：如何换行？**\n一般使用 **两个空格** 加 **回车** 换行，不过一些 IDE 也可以直接使用回车换行。  \n\n\n## 二、分割线\n\n使用三个或以上的 `-` 或者 `*`  表示，且这一行只有符号，**注意不要被识别为二级标题即可**，例如中间或者前面可以加空格\n\n- - -\n\n* * *\n\n\n## 三、斜体和粗体\n\n使用 `*` 和 `**` 分别表示斜体和粗体，例如  \n\n*斜体* \n**粗体** \n***又斜又粗***\n\n#### **扩展：**删除线使用两个 `~` 表示，例如  \n\n~~我是要删掉的文字~~\n\n- - -\n\n\n## 四、超链接和图片\n\n超链接和图片的写法类似，图片仅在超链接前多了一个 `!` ，一般是 [文字描述] (链接)  \n两种写法，分别是： [第一种写法](https://www.baidu.com/) 和 [第二种写法][1]  \n图片的话就比如这样： ![Image][2]  \n\n[1]: https://www.baidu.com/  \n[2]: https://www.zybuluo.com/static/img/logo.png  \n\n- - -\n\n\n## 五、无序列表\n\n使用 `-`、`+` 和 `*` 表示无序列表，前后留一行空白，可嵌套，例如\n\n+ 一层\n    - 二层\n    - 二层\n        * 三层\n            + 四层\n+ 一层\n\n- - -\n\n\n## 六、有序列表\n\n使用 `1. ` （点号后面有个空格）表示有序列表，可嵌套，例如\n\n1. 一层\n    1. 二层\n    2. 二层\n2. 一层\n\n- - -\n\n\n## 七、文字引用\n\n使用 `>` 表示，可以有多个 `>`，表示层级更深，例如\n\n> 第一层\n>>第二层\n>这样是跳不出去的\n>>> 还可以更深\n\n> 这样就跳出去了  \n\n- - -\n\n\n## 八、行内代码块\n\n其实上面已经用过很多次了，即使用 \\` 表示，例如\n\n`行内代码块`\n\n### 扩展：很多字符是需要转义，使用反斜杠 `\\` 进行转义\n\n- - -\n\n\n## 九、代码块\n\n使用四个空格缩进表示代码块，例如\n\n    public class HelloWorld\n    {\n        public static void main(String[] args)\n        { \n            System.out.println( \"Hello, World!\" );\n        }\n    }\n\n一些 IDE 支持行数提示和着色，一般使用三个 \\` 表示，例如\n\n```\npublic class HelloWorld\n{\n    public static void main(String[] args)\n    { \n        System.out.println( \"Hello, World!\" );\n    }\n}\n```\n\n- - -\n\n\n## 十、表格\n\n直接看例子吧，第二行的 `---:` 表示了对齐方式，默认**左对齐**，还有**右对齐**和**居中**  \n\n|商品|数量|单价|\n|---|---:|:---:|\n|苹果苹果苹果|10|\\$1|\n|电脑|1|\\$1999|\n\n- - -\n\n\n## 十一、数学公式\n\n使用 `$` 表示，其中一个 \\$ 表示在行内，两个 \\$ 表示独占一行。\n例如质量守恒公式：$$E=mc^2$$\n支持 **LaTeX** 编辑显示支持，例如：$\\sum_{i=1}^n a_i=0$， 访问 [MathJax][2] 参考更多使用方法。\n\n推荐一个常用的数学公式在线编译网站： [https://www.codecogs.com/latex/eqneditor.php][3]  \n\n[2]: http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference  \n\n[3]: https://www.codecogs.com/latex/eqneditor.php  \n\n- - -\n\n\n## 十二、支持HTML标签\n\n### 1. 例如想要段落的缩进，可以如下：\n\n&nbsp;&nbsp;不断行的空白格&nbsp;或&#160;  \n&ensp;&ensp;半方大的空白&ensp;或&#8194;  \n&emsp;&emsp;全方大的空白&emsp;或&#8195;  \n\n\n- - -\n\n## 十三、其它\n1. markdown 各个 IDE 的使用可能存在大同小异，一般可以参考各个 IDE 的介绍文档\n2. 本文档介绍的内容基本适用于大部分的 IDE\n3. 其它一些类似 **流程图** 之类的功能，需要看 IDE 是否支持。\n\n\n查看原始数据：[https://gitee.com/afei_/MarkdownDemo/raw/master/README.md](https://gitee.com/afei_/MarkdownDemo/raw/master/README.md)\n\n博客：[https://blog.csdn.net/afei__/about/details/80717153](https://blog.csdn.net/afei__/about/details/80717153)",
        id: ''
      },
      aboutRules: {
        nickname: [
          { required: true, message: '请输入昵称', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        github: [
          { required: true, message: '请输入github地址', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        qq: [
          { required: true, message: '请输入QQ号', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        wechat: [
          { required: true, message: '请输入文微信链接', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        bilibili: [
          { required: true, message: '请输入哔哩哔哩地址', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        netease: [
          { required: true, message: '请输入网易云音乐地址', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        email: [
          { required: true, message: '请输入电子邮箱', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        introduction: [
          {
            validator: (rule, value, callback) => {
              console.log('文章验证开始')
              if (this.aboutForm.introduction.length === 0) {
                // 验证失败
                console.log('文章验证失败')
                callback(new Error('请输入自我介绍内容'))
              } else {
                // 验证通过
                callback()
              }
            }
          },
          { required: true, message: '请输入文章内容', trigger: 'blur' }
        ],
        reward: [
          {
            validator: (rule, value, callback) => {
              console.log('图片验证开始')
              if (this.aboutForm.reward.length === 0) {
                // 验证失败
                console.log('图片验证失败')
                callback(new Error('请上传打赏二维码'))
              } else {
                // 验证通过
                callback()
              }
            }
          },
          { required: true, message: '请上传打赏二维码', trigger: 'change' }
        ],
        avatar: [
          {
            validator: (rule, value, callback) => {
              console.log('图片验证开始')
              if (this.aboutForm.avatar.length === 0) {
                // 验证失败
                console.log('图片验证失败')
                callback(new Error('请上传头像'))
              } else {
                // 验证通过
                callback()
              }
            }
          },
          { required: true, message: '请上传头像', trigger: 'change' }
        ]
      }
    }
  },
  computed: {
  },
  watch: {},
  created () {
    this.loadAbout()
  },
  mounted () { },
  methods: {
    // 发布文章
    publishAbout () {
      this.loading = true
      this.$refs['aboutFormRef'].validate(async valid => {
        if (!valid) {
          this.$message.error('请填写正确的个人信息')
          this.loading = false
          return
        }
        console.log('更新文章')
        const { data: res } = await setSingleAbout(this.aboutForm)
        this.$message.success(res.msg)
        this.loading = false
      })
    },
    // 重置表单
    resetForm () {
      this.$confirm('此操作将永久重置已填写的文章表单信息, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$refs['aboutFormRef'].resetFields()
        this.aboutForm.introduction = ''
        this.$message.success('重置成功!')
      }).catch(() => {
        this.$message.info('取消重置!')
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
    uploadSuccess (res) {
      console.log('我是上传钩子', res)
      console.log(res)
      const url = `http://cdn.vologo.cn/${res.key}`
      console.log(url)
      this.aboutForm.cover = url
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
    // 移除图片的钩子
    handleRemove (file, fileList) {
      console.log(file, fileList)
      this.aboutForm.cover = ''
      console.log('移除了照片')
    },
    // 图片预览的钩子
    handlePictureCardPreview (file) {
      console.log('预览了照片')
      this.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    // 限制上传一个的钩子
    handleExceed (files, fileList) {
      this.$message.warning('当前限制上传 1 个文件')
    },
    async loadAbout () {
      const { data: res } = await getSingleAbout(1)
      this.$message.warning('当前为关于我的编辑模式')
      console.log(res.data)
      this.aboutForm = res.data
    },
    async loadQnToken () {
      try {
        const { data: res } = await getQnToken()
        console.log(res)
        this.qnToken = res.data.token
      } catch (e) {
        console.log(e)
      }
    },
    // 绑定@imgAdd event
    async $imgAdd (pos, $file) {
      // 第一步.将图片上传到服务器.
      console.log($file)
      const formdata = new FormData()
      // 七牛云要求请求表头 type 为file，否则会爆error: "file is not specified in multipart"
      formdata.append('file', $file)
      const curr = this.$moment().format('YYYYMMDDHHmmss').toString()
      console.log(curr)
      const suffix = $file.name
      console.log($file.name)
      this.uploadForm.key = curr + '_' + suffix
      console.log(this.uploadForm.key)
      const { data: res } = await getQnToken()
      this.uploadForm.token = res.data.token
      formdata.append('key', this.uploadForm.key)
      formdata.append('token', this.uploadForm.token)
      axios({
        url: 'http://up-z2.qiniu.com',
        method: 'post',
        data: formdata,
        headers: { 'Content-Type': 'multipart/form-data' }
      }).then(async res => {
        // 第二步.将返回的url替换到文本原位置![...](0) -> ![...](url)
        // $vm.$img2Url 详情见本页末尾
        console.log('我是上传钩子', res)
        console.log(res.data.key)
        const url = `http://cdn.vologo.cn/${res.data.key}`
        console.log(url)
        this.imageForm.url = url
        const { data: response } = await createImage(this.imageForm)
        console.log(response)
        // 更新素材列表
        this.$message.success('上传成功!')
        console.log(response)
        this.$refs.md.$img2Url(pos, url)
      })
    }
  }
}
</script>
<style rel="stylesheet/scss" lang="scss" scoped>
.upload_image {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  .el-icon-picture-outline {
    font-size: 222px;
  }
}
</style>
