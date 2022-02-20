<template>
  <!--评论列表-->
  <div>
    <CommentForm v-if="parentCommentId===-1" />
    <h3 class="ui dividing header">Comments | {{ commentCount }} 条评论</h3>
    <h3
      v-if="commentCount===0"
      class="ui header"
    >快来抢沙发！</h3>
    <div
      v-for="comment in comments"
      :key="comment.id"
      class="comment"
    >
      <span
        :id="`comment-${comment.id}`"
        class="anchor"
      />
      <a class="ui circular image avatar">
        <img :src="comment.avatar">
      </a>
      <div class="content">
        <a
          class="nickname"
          :href="comment.website!=''&&comment.website!=null?comment.website:null"
          target="_blank"
          rel="external nofollow noopener"
        >{{ comment.nickname }}</a>
        <div
          v-if="comment.adminComment"
          class="ui black left pointing label"
        >{{ $store.state.siteInfo.commentAdminFlag }}</div>
        <div class="metadata">
          <strong class="date">{{ comment.createTime | dateFormat('YYYY-MM-DD HH:mm') }}</strong>
        </div>
        <el-button
          size="mini"
          type="primary"
          @click="setReply(comment.id)"
        >回复</el-button>
        <div class="text">{{ comment.content }}</div>
      </div>
      <div
        v-if="comment.replyComments.length>0"
        class="comments"
      >
        <div
          v-for="reply in comment.replyComments"
          :key="reply.id"
          class="comment"
        >
          <span
            :id="`comment-${reply.id}`"
            class="anchor"
          />
          <a class="ui circular image avatar">
            <img :src="reply.avatar">
          </a>
          <div class="content">
            <a
              class="nickname"
              :href="reply.website!=''&&reply.website!=null?reply.website:null"
              target="_blank"
              rel="external nofollow noopener"
            >{{ reply.nickname }}</a>
            <div
              v-if="reply.adminComment"
              class="ui black left pointing label"
            >{{ $store.state.siteInfo.commentAdminFlag }}</div>
            <div class="metadata">
              <strong class="date">{{ reply.createTime | dateFormat('YYYY-MM-DD HH:mm') }}</strong>
            </div>
            <div class="text"><a :href="`#comment-${reply.parentCommentId}`">@{{ reply.parentCommentNickname }}</a>{{ reply.content }}</div>
            <div class="actions">
              <el-button
                size="mini"
                type="primary"
                @click="setReply(reply.id)"
              >回复</el-button>
            </div>
          </div>
          <CommentForm v-if="parentCommentId===reply.id" />
        </div>
      </div>
      <CommentForm v-if="parentCommentId===comment.id" />
    </div>
  </div>
</template>
<script>
import { mapState } from 'vuex'
import CommentForm from './CommentForm'
import { SET_PARENT_COMMENT_ID } from '@/store/mutations-types'
export default {
  name: 'Comment',
  components: { CommentForm },
  computed: {
    ...mapState(['commentCount', 'comments', 'parentCommentId'])
  },
  methods: {
    setReply (id) {
      this.$store.commit(SET_PARENT_COMMENT_ID, id)
    }
  }
}
</script>
<style scoped>
.comment {
  padding-right: 2em !important;
  padding-left: 1em !important;
}
.nickname {
  font-weight: bolder;
  color: #000;
}
.comment .el-button {
  margin-left: 5px;
  padding: 4px 5px;
}
.anchor {
  display: block;
  height: 55px;
  margin-top: -55px;
  visibility: hidden;
}
.ui.comments .comment .avatar {
  width: 40px !important;
  margin: 0;
}
.ui.comments .comment .text {
  white-space: pre-wrap !important;
  margin-top: 7px;
  line-height: 1.5;
}
.ui.comments .comment .text a {
  cursor: pointer;
  margin-right: 8px;
  font-weight: bolder;
  color: rgba(0, 0, 0, 0.87);
}
.label {
  cursor: default;
  padding: 4px 6px !important;
  font-weight: 500 !important;
}
.comment .form {
  margin-top: 20px;
}
</style>
