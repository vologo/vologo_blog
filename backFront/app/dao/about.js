const {About} = require('../models/about')

class AboutDao {
  // 新增广告
  static async create(v) {
    // 检测是否存在广告
    const hasAbout = await About.findOne({
      where: {
        nickname: v.get('body.nickname'),
        deleted_at: null
      }
    });

    // 如果存在，抛出存在信息
    if (hasAbout) {
      throw new global.errs.Existing('关于我已存在');
    }

    const about = new About();
    about.avatar = v.get('body.avatar')
    about.nickname = v.get('body.nickname')
    about.github = v.get('body.github')
    about.qq = v.get('body.qq')
    about.wechat = v.get('body.wechat')
    about.bilibili = v.get('body.bilibili')
    about.netease = v.get('body.netease')
    about.email = v.get('body.email')
    about.reward = v.get('body.reward')
    about.introduction = v.get('body.introduction')

    return about.save();
  }

  // 删除广告
  static async destroy(id) {
    const about = await About.findOne({
      where: {
        id,
        deleted_at: null
      }
    });
    if (!about) {
      throw new global.errs.NotFound('没有找到相广告');
    }
    about.destroy()
  }

  // 获取广告详情
  static async detail(id) {
    const about = await About.scope('iv').findOne({
      where: {
        id,
        deleted_at: null
      }
    });
    if (!about) {
      throw new global.errs.NotFound('没有找到相关广告信息');
    }

    return about
  }

  // 更新广告
  static async update(id, v) {
    const about = await About.findByPk(id);
    if (!about) {
      throw new global.errs.NotFound('没有找到相关广告信息');
    }
    about.avatar = v.get('body.avatar')
    about.nickname = v.get('body.nickname')
    about.github = v.get('body.github')
    about.qq = v.get('body.qq')
    about.wechat = v.get('body.wechat')
    about.bilibili = v.get('body.bilibili')
    about.netease = v.get('body.netease')
    about.email = v.get('body.email')
    about.reward = v.get('body.reward')
    about.introduction = v.get('body.introduction')
    about.save();
  }


  // 广告列表
  static async list(page = 1) {
    const pageSize = 10;
    const about = await About.scope('bh').findAndCountAll({
      limit: pageSize,
      offset: (page - 1) * pageSize,
      where: {
        deleted_at: null
      },
      order: [
        ['created_at']
      ],
      attributes: {
        exclude: ['']
      }
    })

    return {
      data: about.rows,
      meta: {
        current_page: parseInt(page),
        per_page: 10,
        count: about.count,
        total: about.count,
        total_pages: Math.ceil(about.count / 10),
      }
    };
  }
}

module.exports = {
  AboutDao
}
