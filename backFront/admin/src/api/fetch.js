import Util from '../libs/util'
import qs from 'qs'
import Vue from 'vue'
import store from '../vuex'
// base64是一种编码转换方式,将ASCII字符转换成普通文本
// base64由字母'a-z','A-Z','0-9','+'和'/',以及'=',共65个字符组成基本字符集,其他字符可根据一定的规则转换成该字符集中的字符
import {Base64} from 'js-base64'
import * as types from '../vuex/mutation-types'
// 设置请求头
Util.ajax.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest'
}
// 请求拦截器
Util.ajax.interceptors.request.use(config => {
  // vue.ls 操作本地storage 的插件
  config.headers['Authorization'] = _encode();
  return config

}, error => {
  return Promise.reject(error)

})

Util.ajax.interceptors.response.use(response => {

  return response

}, error => {
  let {response = {}} = error
  console.log(response)
  if (response.status === 400) {
    Vue.prototype.$Message.error(response.data.msg.join(','))

  } else if (response.status === 401 || response.status === 403) {
    // 登录鉴权失败，清除TOKEN
    Vue.ls.remove("token");

  } else {
    Vue.prototype.$Message.error(response.data.msg)
  }
  // vuex取消loading状态
  store.commit(types.SET_MAIN_LOADING, false);

  return Promise.reject(response)

})

export default {
  post(url, data) {
    return Util.ajax({
      method: 'post',
      url: url,
      data: qs.stringify(data),
      timeout: 30000,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      }
    })
  },

  get(url, params) {
    return Util.ajax({
      method: 'get',
      url: url,
      params
    })
  },

  delete(url, params) {
    return Util.ajax({
      method: 'delete',
      url: url,
      params
    })
  },

  put(url, data) {
    return Util.ajax({
      method: 'put',
      url: url,
      data: qs.stringify(data),
      timeout: 30000,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      }
    })
  }
}

// 转码token
function _encode() {
  const token = Vue.ls.get("token");
  const base64 = Base64.encode(token + ':');
  return 'Basic ' + base64
}
