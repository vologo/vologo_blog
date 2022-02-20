const moment = require('moment');

const {sequelize} = require('../../core/db')
const {Sequelize, Model} = require('sequelize')

// 定义文章模型
class Tag extends Model {

}

// 初始分类模型
Tag.init({
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: Sequelize.STRING,
    allowNull: false,
    comment: '标签名称'
  },
  key: {
    type: Sequelize.STRING,
    allowNull: false,
    comment: '标签关键字'
  },
  color: {
    type: Sequelize.STRING,
    allowNull: true,
    defaultValue:'red',
    comment: '分类颜色'
  },
  created_at: {
    type: Sequelize.DATE,
    allowNull: false,
    get() {
      return moment(this.getDataValue('created_at')).format('YYYY-MM-DD');
    }
  }
},
{
  sequelize,
  modelName: 'tag',
  tableName: 'tag'
})

module.exports = {
  Tag
}
