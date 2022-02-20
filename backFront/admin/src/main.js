import Vue from 'vue'
import VueRouter from 'vue-router';
import Routers from './router'
import Vuex from 'vuex';
import Util from './libs/util'
import App from './app.vue';
import store from './vuex'
// vuex里使用Vue router
import {sync} from 'vuex-router-sync'
import VueLocalStorage from 'vue-ls';
import iView from 'iview';
import 'iview/dist/styles/iview.css';
import './assets/style/admin.css';
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'

Vue.use(VueRouter);
Vue.use(Vuex);
Vue.use(iView);
Vue.use(mavonEditor);
// vue-ls 操作localStorage
Vue.use(VueLocalStorage, {
  namespace: 'boblog-'
});

// 路由配置
const RouterConfig = {
  mode: 'history',
  routes: Routers,
  // 可以在每次路由跳转后手动使滚动条回到头部位置
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return {x: 0, y: 0}
    }
  }
};

const router = new VueRouter(RouterConfig);

// 路由守卫
router.beforeEach(async (to, from, next) => {
  // Iview 的顶部进度条
  iView.LoadingBar.start();
  // 读取路由的meta来设置title
  Util.title(to.meta.title)
  // 获取token
  let token = Vue.ls.get("token");
  if (token) {
    // 如果客户端有token 则验证 token是否有效
    // ('admin/auth') 调用admin命名空间下的actions 的 auth方法
    store.dispatch('admin/auth').then(() => {
      next()

    }).catch(err => {
      Vue.prototype.$Message.error(err.data.msg || '权限未授权')
      setTimeout(() => {
        next('/login')
      }, 1500);
    })

  } else {
    // 判断访问的页面是否需要登录
    // 使用 vue-router 之导航守卫 + meta + localStorage 实现在未登录状态下跳转到登录页面的功能
    if (!!to.meta.noAuth) {
      next()

    } else {
      Vue.prototype.$Message.error('权限未授权')
      setTimeout(() => {
        next('/login')
      }, 1500)
    }
  }
});
// iview vue 全局加载导航进度条设置 loadingBar设置
router.afterEach(() => {
  iView.LoadingBar.finish();
  window.scrollTo(0, 0);
});

sync(store, router)
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router: router,
  store: store,
  render: h => h(App)
})
