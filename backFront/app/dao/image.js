const {Image} = require('../models/image')

class ImageDao {
  // 创建图片
  static async create (params = {}) {
    const { is_collected, url } = params
    const image = new Image();
    image.is_collected = is_collected
    image.url = url
    image.save();

    return {
      is_collected: image.is_collected,
      url: image.url,
      msg: '创建成功'
    }
  }


  // 删除图片
  static async destroy (id) {
    // 查询图片
    const image = await Image.findOne({
      where: {
        id,
        deleted_at: null
      }
    });
    if (!image) {
      throw new global.errs.NotFound('没有找到相关图片');

    }
    image.destroy()
  }

  // 获取图片详情
  // static async detail(id) {
  //   const image = await Image.scope('bh').findOne({
  //     where: {
  //       id,
  //       deleted_at: null
  //     }
  //   });
  //   if (!image) {
  //     throw new global.errs.NotFound('没有找到相关图片');
  //   }

  //   return image
  // }

  // 更新图片
  static async update (id, v) {
    const image = await Image.findByPk(id);
    if (!image) {
      throw new global.errs.NotFound('没有找到相关图片');
    }
    image.is_collected = v.get('body.is_collected');
    // image.url = v.get('body.url');
    image.save();
  }

  // 获取文章列表
  static async list (params = {}) {
    const { collect, page = 1,per_page = 20 } = params;

    // 筛选方式
    let filter = {
      deleted_at: null
    };

    // 筛选方式：存在分类ID
    if (collect !== 'false') {
      filter.is_collected = true;
    }
    const image = await Image.scope('iv').findAndCountAll({
      limit: per_page, //每页10条
      offset: (page - 1) * per_page,
      where: filter,
      order: [
        ['created_at']
      ],
    });

    return {
      data: image.rows,
      // 分页
      meta: {
        current_page: parseInt(page),
        per_page: per_page,
        count: image.count,
        total: image.count,
        total_pages: Math.ceil(image.count / 10),
      }
    };
  }
}
module.exports = {
  ImageDao
}
