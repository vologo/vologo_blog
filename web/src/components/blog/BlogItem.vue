<template>
  <div>
    <div
      v-for="item in blogList"
      :key="item.id"
      class="ui padded attached segment m-padded-tb-large m-margin-bottom-big m-box"
    >
      <div
        v-if="item.top"
        class="ui large red right corner label"
      ><i class="arrow alternate circle up icon" /></div>
      <div class="ui middle aligned mobile reversed stackable">
        <div class="ui grid m-margin-lr">
          <!--标题-->
          <div class="row m-padded-tb-small">
            <h2 class="ui header m-center m-scaleup">
              <a
                href="javascript:;"
                class="m-black"
                @click.prevent="toBlog(item)"
              >{{ item.title }}</a>
            </h2>
          </div>
          <!--文章简要信息-->
          <div class="row m-padded-tb-small">
            <div class="ui horizontal link list m-center">
              <div class="item m-datetime">
                <i class="small calendar icon" />
                <span>{{ item.createTime | dateFormat('YYYY-MM-DD') }}</span>
              </div>
              <div class="item m-views">
                <i class="small eye icon" />
                <span>{{ item.views }}</span>
              </div>
              <div class="item m-common-black">
                <i class="small pencil alternate icon" />
                <span>字数≈{{ item.words }}字</span>
              </div>
              <div class="item m-common-black">
                <i class="small clock icon" />
                <span>阅读时长≈{{ item.readTime }}分</span>
              </div>
            </div>
          </div>
          <!--分类-->
          <router-link
            :to="`/category/${item.category.name}`"
            class="ui orange large ribbon label"
          >
            <i class="small folder open icon" />
            <span class="m-text-500">{{ item.category.name }}</span>
          </router-link>
          <!--文章Markdown描述-->
          <div
            class="typo m-padded-tb-small line-numbers match-braces rainbow-braces"
            v-html="item.description"
          />
          <!--阅读全文按钮-->
          <div class="row m-padded-tb-small m-margin-top">
            <a
              href="javascript:;"
              class="color-btn"
              @click.prevent="toBlog(item)"
            >阅读全文</a>
          </div>
          <!--横线-->
          <div class="ui section divider m-margin-lr-no" />
          <!--标签-->
          <div class="row m-padded-tb-no">
            <div class="column m-padding-left-no">
              <router-link
                v-for="(tag, index) in item.tags"
                :key="index"
                :to="`/tag/${tag.name}`"
                class="ui tag label m-text-500 m-margin-small"
                :class="tag.color"
              >
                {{ tag.name }}
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div
      v-for="(item) in blogList"
      :key="item.id"
      class="recent-post-item"
    >
      <div class="post_cover left_radius">
        <a
          href="javascript:;"
          title="Sticker-Heo表情发布：个人博客的基础表情系列"
          data-pjax-state=""
        >
          <img
            class="post_bg entered loaded"
            data-lazy-src="https://p.zhheo.com/mOSsNu25590181611195475286.png!cover"
            onerror="this.onerror=null,this.src=&quot;/img/404.png&quot;"
            alt="Sticker-Heo表情发布：个人博客的基础表情系列"
            data-ll-status="loaded"
            :src="item.cover"
          ></a>
      </div><a
        v-if="item.category"
        class="article-meta__categories"
        href="javascript:;"
        data-pjax-state=""
      >{{ item.category.name }}</a>
      <div class="recent-post-info">
        <a
          class="article-title"
          href="javascript:;"
          :title="item.title"
          data-pjax-state=""
        >{{ item.title }}</a>
        <div
          class="content"
          onclick="window.open(&quot;/p/2daa6a7b.html&quot;,&quot;_self&quot;)"
        >{{ item.description }}</div>
        <div class="article-meta-wrap">
          <span class="article-meta">
            <span
              v-if="item.category"
              class="sticky"
            >
              <a-icon type="tag" />{{ item.category.name }}
            </span>
            <span class="article-meta__separator">|</span>
          </span>
          <span class="post-meta-date">
            <i class="far fa-calendar-alt" />
            <span class="article-meta-label">创建</span>
            <time
              datetime="2021-01-20T11:28:26.000Z"
              title="创建 2021-01-20 19:28:26"
              style="display: inline;"
            >{{ item.created_at }}</time></span>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'BlogItem',
  props: {
    blogList: {
      type: Array,
      required: true
    }
  },
  methods: {
    toBlog (blog) {
      this.$store.dispatch('goBlogPage', blog)
    }
  }
}
</script>
<style scoped>
@import '../../assets/css/index.css';
@import '../../assets/css/all.min.css';
@import '../../assets/css/instantsearch.min.css';
@import '../../assets/css/remixicon.css';
@import '../../assets/css/snackbar.min.css';
@import '../../assets/css/swiper-bundle.min.css';
@import '../../assets/css/zhheoblog.css';
</style>
