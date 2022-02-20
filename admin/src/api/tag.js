import request from '../utils/request'
// 获取所有分类列表
export const getTag = () => request({
  method: 'GET',
  url: '/tag'
})
// 新增分类
export const createTag = data => request({
  method: 'POST',
  url: '/tag',
  data
})
// 删除单个分类
export const deleteTag = id => request({
  method: 'DELETE',
  url: `/tag/${id}`
})
// 获取单个分类信息
export const getSingleTag = id => request({
  method: 'GET',
  url: `/tag/${id}`
})
// 更新单个分类信息
export const setSingleTag = (data, id) => request({
  method: 'PUT',
  url: `/tag/${id}`,
  data
})
