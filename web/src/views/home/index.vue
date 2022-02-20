<template>
  <div class="home">
    <a-layout style="padding: 24px 0">
      <a-layout-content :style="{ padding: '0 24px', minHeight: '280px',margin:'0 20px 0 0' }">
        <!-- <a-list
          item-layout="vertical"
          size="large"
          :pagination="pagination"
          :data-source="articleList"
        >
          <div slot="footer"><b>ant design vue</b> footer part</div> -->
        <!-- <a-list-item
            slot="renderItem"
            key="item.title"
            slot-scope="item"
          >
            <template slot="actions">
              <span key="user">
                <a-icon
                  type="user"
                  style="margin-right: 8px"
                />
                {{ item.author }}
              </span>
              <span
                v-if="item.category"
                key="tag"
              >
                <a-icon
                  type="tag"
                  style="margin-right: 8px"
                />
                {{ item.category.name }}
              </span>
              <span key="calendar">
                <a-icon
                  type="calendar"
                  style="margin-right: 8px"
                />
                {{ item.created_at }}
              </span>
              <span key="eye">
                <a-icon
                  type="eye"
                  style="margin-right: 8px"
                />
                {{ item.browse }}
              </span>
            </template>
            <img
              slot="extra"
              width="272"
              height="240"
              class="cover"
              :alt="item.title"
              :src="item.cover"
            >
            <a-list-item-meta :description="item.description">
              <a
                slot="title"
                :href="item.href"
              >{{ item.title }}</a>
              <a-avatar
                slot="avatar"
                src="https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png"
              />
            </a-list-item-meta>
            {{ item.content }}
          </a-list-item>
        </a-list> -->
        <div
          id="recent-posts"
          class="recent-posts"
        >
          <div
            id="categoryList"
            class="categoryList"
          >
            <div class="categoryItem">
              <a
                class="categoryButton"
                href="javascript:;"
                style="background:#56ccf2;background:-webkit-linear-gradient(to right,#2f80ed,#56ccf2);background:linear-gradient(to right,#2f80ed,#56ccf2)"
                data-pjax-state=""
              ><i class="fas fa-dove">必看精选</i></a>
            </div>
            <div class="categoryItem">
              <a
                class="categoryButton"
                href="javascript:;"
                style="background:#f12711;background:-webkit-linear-gradient(to right,#f12711,#f5af19);background:linear-gradient(to right,#f12711,#f5af19)"
                data-pjax-state=""
              ><i class="fas fa-burn">热门文章</i></a>
            </div>
            <div class="categoryItem">
              <a
                class="categoryButton"
                href="javascript:;"
                style="background:#f953c6;background:-webkit-linear-gradient(to right,#b91d73,#f953c6);background:linear-gradient(to right,#b91d73,#f953c6)"
                data-pjax-state=""
              ><i class="fas fa-apple-alt">实用干货</i></a>
            </div>
            <div class="categoryItem">
              <a
                class="categoryButton"
                href="javascript:;"
                style="background:#11998e;background:-webkit-linear-gradient(to left,#38ef7d,#11998e);background:linear-gradient(to left,#38ef7d,#11998e)"
                data-pjax-state=""
              ><i class="fas fa-lemon">超赞教程</i></a>
            </div>
          </div>
          <div
            id="bbTimeList"
            class="bbTimeList container"
          >
            <i
              class="bber-logo iconfont icon-bblogo"
              onclick="location=&quot;/essay/&quot;"
              title="即刻短文"
              style="font-size:2rem"
            />
            <div
              id="bbtalk"
              class="swiper-container"
            >
              <div
                id="bber-talk"
                class="swiper-wrapper"
                onclick="location=&quot;/essay/&quot;"
              />
            </div><i
              class="bber-gotobb fas fa-arrow-circle-right"
              onclick="location=&quot;/essay/&quot;"
              title="查看全文"
            />
          </div>
          <!-- <div class="js-pjax">
        <script
          src="static/js/swiper-bundle.min.js"
          data-pjax=""
        ></script>
        <script
          src="static/js/showbb_in_index.js"
          data-pjax=""
          defer=""
        ></script>
      </div> -->
          <div
            v-for="(item) in articleList"
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
      </a-layout-content>
    </a-layout>
  </div>
</template>
<script>
import { getArticle, deleteArticle, queryArticle } from '@/api/article'
import { mapState, mapActions } from 'vuex'
export default {
  name: 'Article',
  // components: { ElImageViewer },
  props: {},
  data () {
    return {
      articleList: [],
      // categoryList: [],
      loading: true,
      // 表头搜索
      search: '',
      // 总页数
      total: 0,
      showViewer: false, // 显示查看器
      queryForm: {
        page: 1, // 查询第一页
        category_id: '', // 按分类id来查询
        desc: 'created_at', // 排序，默认最新：created_at，浏览次数：browse
        keyword: '' // 按关键字搜索
      },
      pagination: {
        onChange: page => {
          this.queryForm.page = page
          this.loadArticle()
        },
        pageSize: 10,
        total: 0
      }
    }
  },
  computed: {
  },
  watch: {},
  created () {
    this.loadArticle()
  },
  mounted () { },
  methods: {
    // 获取所有的文章
    async loadArticle () {
      this.loading = true
      const { data: res } = await getArticle(this.queryForm)
      this.articleList = res.data.data
      this.pagination.total = res.data.meta.total
      this.loading = false
    },
    // 搜索功能
    async handleQuery () {
      // if (!this.queryForm.keyword) {
      this.loadArticle()
      // } else {
      //   console.log(this.queryForm)
      //   const { data: res } = await queryArticle(this.queryForm)
      //   this.categoryList = res.data
      // }
    },
    details (id) {
      console.log(id)
    }
    // onChange (current) {
    //   this.queryForm.page = current
    //   this.loadArticle()
    // }
    // // 翻页功能
    // handleCurrentChange (current) {
    //   this.queryForm.page = current
    //   this.loadArticle()
    // },
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
.cover {
  object-fit: cover;
  border-radius: 5px;
}
/* // .ant-list-item {
//   display: flex;
//   justify-content: space-between;
//   flex-flow: row-reverse !important;
// } */
.article-meta__categories {
  background-color: #fff !important;
}
.article-meta__categories:hover {
  background-color: #425aef !important;
}
.recent-post-info {
  background: #fff;
  border-radius: 0 12px 12px 0 !important;
}
</style>
