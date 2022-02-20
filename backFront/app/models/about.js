const moment = require('moment');

const {sequelize} = require('../../core/db')
const {Sequelize, Model} = require('sequelize')

// 定义关于我模型
class About extends Model {

}

// 初始关于我模型
About.init({
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  avatar: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-头像'
  },
  nickname: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-昵称'
  },
  github: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-github地址'
  },
  qq: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-qq地址'
  },
  wechat: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-微信地址'
  },
  bilibili: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-哔哩哔哩地址'
  },
  netease: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-网易云音乐地址'
  },
  email: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-电子邮箱地址'
  },
  reward: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-打赏二维码地址'
  },
  introduction: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '关于我-自我介绍'
  },
  created_at: {
    type: Sequelize.DATE,
    allowNull: false,
    get() {
      return moment(this.getDataValue('created_at')).format('YYYY-MM-DD');
    }
  }
}, {
  sequelize,
  modelName: 'about',
  tableName: 'about'
})

module.exports = {
  About
}
