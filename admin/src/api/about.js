import request from '../utils/request'
// 创建关于我（友情链接）
export const createAbout = data => request({
  method: 'POST',
  url: '/about',
  data
})
// 获取单个关于我详情
export const getSingleAbout = id => request({
  method: 'GET',
  url: `/about/${id}`
})
// 获取所有关于我
export const getAbout = params => request({
  method: 'GET',
  url: '/about',
  params
})
// 更新单个关于我
export const setSingleAbout = data => request({
  method: 'PUT',
  url: `/about/${data.id}`,
  data
})
// 删除单篇关于我
export const deleteAbout = id => request({
  method: 'DELETE',
  url: `/about/${id}`
})
