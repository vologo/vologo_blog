const moment = require('moment');

const {sequelize} = require('../../core/db')
const {Sequelize, Model} = require('sequelize')

// 定义友链模型
class Friend extends Model {

}

// 初始友链模型
Friend.init({
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '友链名称'
  },
  link: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '友链链接'
  },
  avatar: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '友链头像'
  },
  description: {
    type: Sequelize.STRING(64),
    allowNull: false,
    comment: '友链描述'
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
  modelName: 'friend',
  tableName: 'friend'
})

module.exports = {
  Friend
}
