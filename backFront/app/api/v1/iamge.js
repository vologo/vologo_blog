/**
 * @description 图片的路由 API 接口
 * @description Image's routing API interface
 * @author 梁凤波, Peter Liang
 */

const Router = require('koa-router');

const {
  ImageValidator,
  PositiveIdParamsValidator
} = require('../../validators/image');

const {ImageDao} = require('../../dao/image');
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
 * 创建图片
 */
router.post('/image', new Auth(AUTH_ADMIN).m, async (ctx) => {
  // 通过验证器校验参数是否通过
  const v = await new ImageValidator().validate(ctx);
  const result = await ImageDao.create({
    is_collected: v.get('body.is_collected'),
    url: v.get('body.url'),
  });

  // 返回结果
  ctx.response.status = 200;
  ctx.body = res.json(result)
})


/**
 * 删除文章
 */
router.delete('/image/:id', new Auth(AUTH_ADMIN).m, async (ctx) => {

  // 通过验证器校验参数是否通过
  const v = await new PositiveIdParamsValidator().validate(ctx);

  // 获取图片ID参数
  const id = v.get('path.id');
  // 删除图片
  await ImageDao.destroy(id);

  ctx.response.status = 200;
  ctx.body = res.success('删除图片成功');
})


/**
 * 更新图片
 */
router.put('/image/:id', new Auth(AUTH_ADMIN).m, async (ctx) => {

  // 通过验证器校验参数是否通过
  const v = await new PositiveIdParamsValidator().validate(ctx);

  // 获取图片ID参数
  const id = v.get('path.id');
  // 更新图片
  await ImageDao.update(id, v);

  // 返回结果
  ctx.response.status = 200;
  ctx.body = res.success('更新图片成功');
})

/**
 * 获取所有的图片
 */
router.get('/image', async (ctx) => {
  // 尝试获文章取缓存
  // const {collect = 'false', page = 1} = ctx.query;
  // const key = `${REDIS_KEY_API_PREFIX}_image_list_is_collected${collect}_page${page}`
  // const cacheImageListData = await getRedis(key)
  // if (cacheImageListData) {
  //   // 返回结果
  //   ctx.body = res.json(cacheImageListData);
  // } else {
    const imageList = await ImageDao.list(ctx.query);
    // setRedis(key, imageList, 60)
    // 返回结果
    ctx.response.status = 200;
    ctx.body = res.json(imageList);
  // }
})



module.exports = router
