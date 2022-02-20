import { getTag } from '@/api/tag'
import * as types from '../mutation-types'
const state = {
  tagList: []
}
const mutations = {
  [types.SET_TAG] (state, data) {
    state.tagList = data
  }
}
const actions = {
  async LoadTag({ commit }) {
    const { data: res } = await getTag()
    commit('SET_TAG', res.data)
  }
}
export default {
  namespaced: true,
  state,
  mutations,
  actions
}
