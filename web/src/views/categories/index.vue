<template>
  <div class="category">
    <a-layout style="padding: 24px 0">
      <a-layout-content :style="{ padding: '0 24px', minHeight: '280px',margin:'0 20px 0 0' }">
        <a-list
          item-layout="vertical"
          size="large"
          :pagination="pagination"
          :data-source="articleList"
        >
          <!-- <div slot="footer"><b>ant design vue</b> footer part</div> -->
          <a-list-item
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
        </a-list>
      </a-layout-content>
    </a-layout>
  </div>
</template>
<script>
import { mapState, mapMutations, mapActions } from 'vuex'
import { getArticle, deleteArticle, queryArticle } from '@/api/article'
export default {
  name: 'Category',
  components: {},
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
    ...mapState('category', ['categoryId'])
  },
  watch: {
    categoryId (val) {
      console.log(val)
      this.queryForm.category_id = val
      this.loadArticle()
    }
  },
  created () {
    if (this.$route.query.category) {
      this.queryForm.category_id = this.categoryId
      this.loadArticle()
    }
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
    }
  }
}
</script>
<style rel="stylesheet/scss" lang="scss" scoped></style>
