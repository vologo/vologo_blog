<template>
  <!-- 评论输入表单 -->
  <div class="form">
    <h3>
      发表评论
      <el-button
        v-show="parentCommentId!==-1"
        class="m-small"
        size="mini"
        type="primary"
        @click="$store.commit(SET_PARENT_COMMENT_ID, -1)"
      >取消回复</el-button>
    </h3>
    <el-form
      ref="formRef"
      :inline="true"
      :model="commentForm"
      :rules="formRules"
      size="small"
    >
      <el-input
        v-model="commentForm.content"
        :class="'textarea'"
        type="textarea"
        :rows="5"
        placeholder="评论千万条，友善第一条"
        maxlength="250"
        show-word-limit
        :validate-event="false"
      />
      <el-form-item prop="nickname">
        <el-popover
          ref="nicknamePopover"
          placement="bottom"
          trigger="focus"
          content="输入QQ号将自动拉取昵称和头像"
        />
        <el-input
          v-model="commentForm.nickname"
          v-popover:nicknamePopover
          placeholder="昵称（必填）"
          :validate-event="false"
        >
          <i
            slot="prefix"
            class="el-input__icon el-icon-user"
          />
        </el-input>
      </el-form-item>
      <el-form-item prop="email">
        <el-popover
          ref="emailPopover"
          placement="bottom"
          trigger="focus"
          content="用于接收回复邮件"
        />
        <el-input
          v-model="commentForm.email"
          v-popover:emailPopover
          placeholder="邮箱（必填）"
          :validate-event="false"
        >
          <i
            slot="prefix"
            class="el-input__icon el-icon-message"
          />
        </el-input>
      </el-form-item>
      <el-form-item>
        <el-popover
          ref="websitePopover"
          placement="bottom"
          trigger="focus"
          content="可以让我参观一下吗😊"
        />
        <el-input
          v-model="commentForm.website"
          v-popover:websitePopover
          placeholder="https://（可选）"
        >
          <i
            slot="prefix"
            class="el-input__icon el-icon-map-location"
          />
        </el-input>
      </el-form-item>
      <el-form-item label="订阅回复">
        <el-switch v-model="commentForm.notice" />
      </el-form-item>
      <el-form-item>
        <el-button
          v-throttle="[postForm,`click`,3000]"
          type="primary"
          size="medium"
        >发表评论</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
import { mapState } from 'vuex'
import { checkEmail } from '@/common/reg'
import { SET_PARENT_COMMENT_ID } from '@/store/mutations-types'
export default {
  name: 'CommentForm',
  computed: {
    ...mapState(['parentCommentId', 'commentForm', 'commentQuery'])
  },
  data () {
    return {
      SET_PARENT_COMMENT_ID,
      formRules: {
        nickname: [
          { required: true, message: '请输入评论昵称' },
          { max: 18, message: '昵称不可多于15个字符' }
        ],
        email: [
          { required: true, message: '请输入评论邮箱' },
          { validator: checkEmail }
        ]
      }
    }
  },
  methods: {
    postForm () {
      const adminToken = window.sessionStorage.getItem('adminToken')
      if (adminToken) {
        // 博主登录后，sessionStorage中会存储token，在后端设置属性，可以不校验昵称、邮箱
        if (this.commentForm.content === '' || this.commentForm.content.length > 250) {
          return this.$notify({
            title: '评论失败',
            message: '评论内容有误',
            type: 'warning'
          })
        } else {
          return this.$store.dispatch('submitCommentForm', adminToken)
        }
      }
      const blogToken = window.localStorage.getItem(`blog${this.commentQuery.blogId}`)
      this.$refs.formRef.validate(valid => {
        if (!valid || this.commentForm.content === '' || this.commentForm.content.length > 250) {
          this.$notify({
            title: '评论失败',
            message: '请正确填写评论',
            type: 'warning'
          })
        } else {
          this.$store.dispatch('submitCommentForm', blogToken || '')
        }
      })
    }
  }
}
</script>
<style>
.form h3 {
  margin: 5px;
  font-weight: 500 !important;
}
.form .m-small {
  margin-left: 5px;
  padding: 4px 5px;
}
.el-form .textarea {
  margin-top: 5px;
  margin-bottom: 15px;
}
</style>
