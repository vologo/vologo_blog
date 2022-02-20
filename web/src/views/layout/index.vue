<template>
  <a-layout id="components-layout-demo-top-side">
    <!-- 顶部导航栏 -->
    <a-layout-header
      class="header"
      :style="{ position: 'fixed', zIndex: 1, width: '100%' }"
    >
      <div class="logo" />
      <a-menu
        theme="dark"
        mode="horizontal"
        :default-selected-keys="['']"
        :style="{ lineHeight: '64px' }"
        @click="handleClick"
      >
        <a-menu-item key="">首页</a-menu-item>
        <a-menu-item key="archives">归档</a-menu-item>
        <a-menu-item key="moments">动态</a-menu-item>
        <a-menu-item key="advertise">友链</a-menu-item>
        <a-menu-item key="about">关于</a-menu-item>
      </a-menu>
    </a-layout-header>
    <!-- 主题区域 -->
    <a-layout-content class="content-main">
      <a-layout style="padding: 24px 0; background: #f5f5f7">
        <a-layout-content :style="{ padding: '0 24px', minHeight: '1100px' }">
          <router-view />
        </a-layout-content>
        <a-layout-sider
          width="200"
          style="background: #f5f5f7;margin:30px 0 0 0;"
        >
          <a-card title="分类云">
            <a
              slot="extra"
              href="#"
            >
              <a-icon type="tags" />
            </a>
            <a-tag
              v-for="item,index in categoryList"
              :key="item.key"
              :color="color[index]"
              @click="clickTags(item.id,item.key)"
            >
              {{ item.name }}
            </a-tag>
          </a-card>
        </a-layout-sider>
      </a-layout>
    </a-layout-content>
    <a-layout-footer style="text-align: center">
      <a
        href="http://www.beian.miit.gov.cn"
        data-v-2ab60ee7=""
      >蜀ICP备2020030845号-1</a>
    </a-layout-footer>
  </a-layout>
</template>
<script>
import { mapState, mapMutations, mapActions } from 'vuex'
export default {
  name: 'LayouIndex',
  components: {},
  props: {},
  data () {
    return {
      color: [
        'pink',
        'red',
        'orange',
        'green',
        'cyan',
        'blue',
        'purple',
        'silver',
        'black',
        'fuchsia',
        'yelow'
      ]
    }
  },
  computed: {
    ...mapState('category', ['categoryList'])
  },
  watch: {},
  created () {
    this.LoadCategory()
  },
  mounted () { },
  methods: {
    // 首屏数据请求 所有的分类
    ...mapActions('category', ['LoadCategory']),
    ...mapMutations('category', ['SET_CATEGORYID']),
    handleClick ({ key }) {
      this.$router.push(`/${key}`)
    },
    clickTags (id, key) {
      console.log(id)
      this.SET_CATEGORYID(id)
      this.$router.push(`/categories?category=${key}`)
    }
  }
}
</script>
<style rel="stylesheet/scss" lang="scss" scoped>
#components-layout-demo-top-side .logo {
  width: 120px;
  height: 31px;
  background: rgba(255, 255, 255, 0.2);
  margin: 16px 28px 16px 0;
  float: left;
}
.ant-tag {
  margin-bottom: 10px;
}
</style>
