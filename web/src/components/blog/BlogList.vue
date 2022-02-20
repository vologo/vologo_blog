<template>
  <div>
    <!--content-->
    <BlogItem
      v-viewer
      :blog-list="blogList"
    />
    <!--分页-->
    <Pagination
      :get-blog-list="getBlogList"
      :total-page="totalPage"
    />
  </div>
</template>
<script>
import BlogItem from './BlogItem'
import Pagination from './Pagination'
export default {
  name: 'BlogList',
  components: { Pagination, BlogItem },
  props: {
    getBlogList: {
      type: Function,
      required: true
    },
    blogList: {
      type: Array,
      required: true
    },
    totalPage: {
      type: Number,
      required: true
    }
  }
}
</script>
<style scoped>
</style>
