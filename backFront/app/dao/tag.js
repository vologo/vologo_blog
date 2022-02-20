const {Tag} = require('../models/tag')

class TagDao {
  // 创建分类
  static async create(params = {}) {
    const {name, key,color} = params
    // 查询是否存在重复的分类
    const hasTag = await Tag.findOne({
      where: {
        key,
        deleted_at: null
      }
    });

    if (hasTag) {
      throw new global.errs.Existing('分类已存在');
    }

    const tag = new Tag();
    tag.name = name
    tag.key = key
    tag.color = color
    tag.save();

    return {
      name: tag.name,
      key: tag.key,
      color:tag.color,
      msg: '创建成功'
    }
  }


  // 删除分类
  static async destroy(id) {
    // 查询分类
    const tag = await Tag.findOne({
      where: {
        id,
        deleted_at: null
      }
    });
    if (!tag) {
      throw new global.errs.NotFound('没有找到相关分类');

    }
    tag.destroy()
  }

  // 获取分类详情
  static async detail(id) {
    const tag = await Tag.scope('bh').findOne({
      where: {
        id,
        deleted_at: null
      }
    });
    if (!tag) {
      throw new global.errs.NotFound('没有找到相关分类');
    }

    return tag
  }

  // 更新分类
  static async update(id, v) {
    const tag = await Tag.findByPk(id);
    if (!tag) {
      throw new global.errs.NotFound('没有找到相关分类');
    }
    tag.name = v.get('body.name');
    tag.key = v.get('body.key');
    tag.color = v.get('body.color')
    tag.save();
  }

  // 分类列表
  static async list() {
    return await Tag.scope('bh').findAll({
      where: {
        deleted_at: null
      }
    });
  }
}

module.exports = {
  TagDao
}
