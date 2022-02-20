import request from '../utils/request'
// 获取所有图片列表
export const getImage = params => request({
  method: 'GET',
  url: '/image',
  params
})
// 新增图片
export const createImage = data => request({
  method: 'POST',
  url: '/image',
  data
})
// 删除单个图片
export const deleteImage = id => request({
  method: 'DELETE',
  url: `/image/${id}`
})
// 获取单个图片信息
export const getSingleImage = id => request({
  method: 'GET',
  url: `/image/${id}`
})
// 更新单个图片信息
export const setSingleImage = (data, id) => request({
  method: 'PUT',
  url: `/image/${id}`,
  data
})
