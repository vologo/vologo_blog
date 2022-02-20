import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import VueParticles from 'vue-particles'
import ElementUI from 'element-ui'
// import Storage from 'vue-ls'
// 全局样式表
import '@/styles/index.scss'
import 'element-ui/lib/theme-chalk/index.css'
import moment from 'moment'
Vue.prototype.$moment = moment
Vue.use(VueParticles)
Vue.use(ElementUI)
// Vue.use(Storage, {
//   namespace: 'vologo__', // key键前缀 比如abc存的数据 为 vologo_abc
//   name: 'ls', // 命名Vue变量.[ls]或this.[$ls],
//   storage: 'local' // 存储名称: session, local=》localSession, memory
// })
// 创建 Vue 根实例
// 把 router 配置到根实例中
// 通过 render 方法把 App 根组件渲染到 #app 入口节点
Vue.config.productionTip = false
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
