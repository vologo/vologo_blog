import axios from 'axios'
// import store from '../vuex'
import store from '@/store/'
// import Vue from 'vue'
import router from '@/router'
// import { Base64 } from 'js-base64'
// 设置基本信息
const request = axios.create({
  baseURL: process.env.VUE_APP_REQUEST_URL + process.env.VUE_APP_BASE_API,
  timeout: 100000
})
// 设置请求头
request.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest'
}
// 请求拦截器
request.interceptors.request.use(config =>
  // if (store.state.user.userToken) {
  //   const token = Base64.encode(store.state.user.userToken + ':')
  //   config.headers.Authorization = 'Basic ' + token
  // }
  config
, error => Promise.reject(error) // 请求失败，会经过这里
)
// 响应拦截器
request.interceptors.response.use(response =>
  response
,
error => {
  const { response = {}} = error
  console.log(response)
  return Promise.reject(error)
})
export default request
