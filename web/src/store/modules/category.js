import { getCategory } from '@/api/category'
import * as types from '../mutation-types'
const state = {
  categoryList: [],
  categoryId: -1
}
const mutations = {
  [types.SET_CATEGORY] (state, data) {
    state.categoryList = data
  },
  [types.SET_CATEGORYID] (state, id) {
    state.categoryId = id
  }
}
const actions = {
  async LoadCategory ({ commit }) {
    const { data: res } = await getCategory()
    commit('SET_CATEGORY', res.data)
  }
}
export default {
  namespaced: true,
  state,
  mutations,
  actions
}
