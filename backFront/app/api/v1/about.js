const Router = require('koa-router')

const {AboutDao} = require('../../dao/about')
const {AboutValidator, PositiveArticleIdParamsValidator} = require('../../validators/about')
const {Auth} = require('../../../middlewares/auth');

const {Resolve} = require('../../lib/helper');
const res = new Resolve();

const AUTH_ADMIN = 16;

const {getRedis, setRedis} = require('../../cache/_redis')
// redis key 前缀
const REDIS_KEY_API_PREFIX = 'boblog_api'

const router = new Router({
  prefix: '/api/v1'
})

// 创建关于我
router.post('/about', async (ctx) => {
  // 通过验证器校验参数是否通过
  const v = await new AboutValidator().validate(ctx);
  // 创建回复
  const r = await AboutDao.create(v);

  // 返回结果
  ctx.response.status = 200;
  ctx.body = res.json(r);
})

// 删除关于我
router.delete('/about/:id', new Auth(AUTH_ADMIN).m, async (ctx) => {

  // 通过验证器校验参数是否通过
  const v = await new PositiveArticleIdParamsValidator().validate(ctx);

  // 获取关于我ID参数
  const id = v.get('path.id');
  await AboutDao.destroy(id);

  // 返回结果
  ctx.response.status = 200;
  ctx.body = res.success('删除关于我成功')
})

// 修改关于我
router.put('/about/:id', new Auth(AUTH_ADMIN).m, async (ctx) => {

  // 通过验证器校验参数是否通过
  const v = await new PositiveArticleIdParamsValidator().validate(ctx);

  // 获取关于我ID参数
  const id = v.get('path.id');
  await AboutDao.update(id, v);

  // 返回结果
  ctx.response.status = 200;
  ctx.body = res.success('更新关于我成功')
})

// 获取关于我列表
router.get('/about', async (ctx) => {
  const key = `${REDIS_KEY_API_PREFIX}_about_list`
  const cacheAboutListData = await getRedis(key)
  if (cacheAboutListData) {
    console.log('关于我缓存')
    // 返回结果
    ctx.body = res.json(cacheAboutListData);

  } else {
    const page = ctx.query.page;
    const aboutlist = await AboutDao.list(page);

    setRedis(key, aboutlist, 60)
    // 返回结果
    ctx.response.status = 200;
    ctx.body = res.json(aboutlist);
  }

})

// 获取关于我详情
router.get('/about/:id', async (ctx) => {
  // 通过验证器校验参数是否通过
  const v = await new PositiveArticleIdParamsValidator().validate(ctx);

  // 获取关于我ID参数
  const id = v.get('path.id');
  const data = await AboutDao.detail(id)

  // 返回结果
  ctx.response.status = 200;
  ctx.body = res.json(data);

})

module.exports = router
