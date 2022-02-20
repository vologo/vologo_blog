/**
 * @description 分类的路由 API 接口
 * @description Tag's routing API interface
 * @author 梁凤波, Peter Liang
 */

 const Router = require('koa-router');

 const {
   TagValidator,
   PositiveIdParamsValidator
 } = require('../../validators/tag');
 
 const {TagDao} = require('../../dao/tag');
 const {Auth} = require('../../../middlewares/auth');
 
 const {Resolve} = require('../../lib/helper');
 const res = new Resolve();
 
 const {getRedis, setRedis} = require('../../cache/_redis')
 // redis key 前缀
 const REDIS_KEY_API_PREFIX = 'boblog_api'
 
 const AUTH_ADMIN = 16;
 
 const router = new Router({
   prefix: '/api/v1'
 })
 
 /**
  * 创建分类
  */
 router.post('/tag', new Auth(AUTH_ADMIN).m, async (ctx) => {
   // 通过验证器校验参数是否通过
   const v = await new TagValidator().validate(ctx);
   const result = await TagDao.create({
     name: v.get('body.name'),
     key: v.get('body.key'),
     color: v.get('body.color'),
   });
 
   // 返回结果
   ctx.response.status = 200;
   ctx.body = res.json(result)
 })
 
 
 /**
  * 删除文章
  */
 router.delete('/tag/:id', new Auth(AUTH_ADMIN).m, async (ctx) => {
 
   // 通过验证器校验参数是否通过
   const v = await new PositiveIdParamsValidator().validate(ctx);
 
   // 获取分类ID参数
   const id = v.get('path.id');
   // 删除分类
   await TagDao.destroy(id);
 
   ctx.response.status = 200;
   ctx.body = res.success('删除分类成功');
 })
 
 
 /**
  * 更新分类
  */
 router.put('/tag/:id', new Auth(AUTH_ADMIN).m, async (ctx) => {
 
   // 通过验证器校验参数是否通过
   const v = await new PositiveIdParamsValidator().validate(ctx);
 
   // 获取分类ID参数
   const id = v.get('path.id');
   // 更新分类
   await TagDao.update(id, v);
 
   // 返回结果
   ctx.response.status = 200;
   ctx.body = res.success('更新分类成功');
 })
 
 /**
  * 获取所有的分类
  */
 router.get('/tag', async (ctx) => {
   const key = `${REDIS_KEY_API_PREFIX}_tag_list`
   const cacheTagListData = await getRedis(key)
   if (cacheTagListData) {
     // 返回结果
     ctx.body = res.json(cacheTagListData);
   } else {
     const tagList = await TagDao.list();
     setRedis(key, tagList, 60)
     // 返回结果
     ctx.response.status = 200;
     ctx.body = res.json(tagList);
   }
 })
 
 /**
  * 获取分类详情
  */
 router.get('/tag/:id', async (ctx) => {
 
   // 通过验证器校验参数是否通过
   const v = await new PositiveIdParamsValidator().validate(ctx);
 
   // 获取参数
   const id = v.get('path.id');
   // 获取分类
   const tag = await TagDao.detail(id);
 
   // 返回结果
   ctx.response.status = 200;
   ctx.body = res.json(tag);
 })
 
 module.exports = router
 