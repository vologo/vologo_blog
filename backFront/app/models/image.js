const moment = require('moment');

const {sequelize} = require('../../core/db')
const {Sequelize, Model} = require('sequelize')

// 定义文章模型
class Image extends Model {

}

// 初始分类模型
Image.init({
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  is_collected: {
    type: Sequelize.BOOLEAN,
    allowNull: false,
    comment: '是否收藏'
  },
  url: {
    type: Sequelize.STRING,
    allowNull: false,
    comment: '素材链接'
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
  modelName: 'image',
  tableName: 'image'
})

module.exports = {
  Image
}
