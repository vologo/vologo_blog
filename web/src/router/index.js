import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)
const routes = [
  {
    path: '/login',
    name: 'login',
    component: () => import('@/views/login/'),
    meta: { title: '登录' }
  },
  {
    path: '/',
    component: () => import('@/views/layout/'),
    children: [
      {
        path: '',
        name: 'home',
        component: () => import('@/views/home/'),
        meta: { title: '主页' }
      },
      {
        path: '/categories',
        name: 'categories',
        component: () => import('@/views/categories/'),
        meta: { title: '分类' }
      },
      {
        path: '/blog',
        name: 'articles',
        component: () => import('@/views/articles/'),
        meta: {
          title: '博客'
        }
      },
      {
        path: '/archives',
        name: 'archives',
        component: () => import('@/views/moments/'),
        meta: { title: '归档' }
      },
      {
        path: '/moments',
        name: 'moments',
        component: () => import('@/views/moments/'),
        meta: { title: '动态' }
      },
      {
        path: '/advertise',
        name: 'advertise',
        component: () => import('@/views/advertise/'),
        meta: { title: '友链' }
      },
      {
        path: '/about',
        name: 'about',
        component: () => import('@/views/about/'),
        meta: { title: '关于' }
      }
    ]
  }
]
const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})
export default router
