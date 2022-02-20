const {Friend} = require('../models/friend')

class FriendDao {
  // 新增广告
  static async create(v) {
    // 检测是否存在广告
    const hasFriend = await Friend.findOne({
      where: {
        title: v.get('body.title'),
        deleted_at: null
      }
    });

    // 如果存在，抛出存在信息
    if (hasFriend) {
      throw new global.errs.Existing('广告已存在');
    }

    const friend = new Friend();
    friend.title = v.get('body.title')
    friend.link = v.get('body.link')

    return friend.save();
  }

  // 删除广告
  static async destroy(id) {
    const friend = await Friend.findOne({
      where: {
        id,
        deleted_at: null
      }
    });
    if (!friend) {
      throw new global.errs.NotFound('没有找到相广告');
    }
    friend.destroy()
  }

  // 获取广告详情
  static async detail(id) {
    const friend = await Friend.scope('iv').findOne({
      where: {
        id,
        deleted_at: null
      }
    });
    if (!friend) {
      throw new global.errs.NotFound('没有找到相关广告信息');
    }

    return friend
  }

  // 更新广告
  static async update(id, v) {
    const friend = await Friend.findByPk(id);
    if (!friend) {
      throw new global.errs.NotFound('没有找到相关广告信息');
    }
    friend.title = v.get('body.title');
    friend.link = v.get('body.link');

    friend.save();
  }


  // 广告列表
  static async list(page = 1) {
    const pageSize = 10;
    const friend = await Friend.scope('bh').findAndCountAll({
      limit: pageSize,
      offset: (page - 1) * pageSize,
      where: {
        deleted_at: null
      },
      order: [
        ['created_at', 'DESC']
      ],
      attributes: {
        exclude: ['email']
      }
    })

    return {
      data: friend.rows,
      meta: {
        current_page: parseInt(page),
        per_page: 10,
        count: friend.count,
        total: friend.count,
        total_pages: Math.ceil(friend.count / 10),
      }
    };
  }
}

module.exports = {
  FriendDao
}
