const {
  Rule,
  LinValidator
} = require('../../core/lin-validator-v2')

class AboutValidator extends LinValidator {
  constructor() {
    super()
    this.avatar = [
      new Rule("isLength", "关于我-头像 avatar 不能为空", {min: 1})
    ]
    this.nickname = [
      new Rule("isLength", "关于我-昵称 nickname 不能为空", {min: 1})
    ]
    this.github = [
      new Rule("isLength", "关于我-github地址 github 不能为空", {min: 1})
    ]
    this.qq = [
      new Rule("isLength", "关于我-qq号 qq 不能为空", {min: 1})
    ]
    this.wechat = [
      new Rule("isLength", "关于我-微信地址 wechat 不能为空", {min: 1})
    ]
    this.bilibili = [
      new Rule("isLength", "关于我-哔哩哔哩地址 bilibili 不能为空", {min: 1})
    ]
    this.netease = [
      new Rule("isLength", "关于我-网易云音乐地址 netease 不能为空", {min: 1})
    ]
    this.email = [
      new Rule("isLength", "关于我-电子邮箱 email 不能为空", {min: 1})
    ]
    this.reward = [
      new Rule("isLength", "关于我-打赏二维码地址 reward 不能为空", {min: 1})
    ]
    this.introduction = [
      new Rule("isLength", "关于我-自我介绍 introduction 不能为空", {min: 1})
    ]
  }
}

class PositiveArticleIdParamsValidator extends LinValidator {
  constructor() {
    super();
    this.id = [
      new Rule('isInt', 'ID需要正整数', {min: 1})
    ]
  }
}

module.exports = {
  AboutValidator,
  PositiveArticleIdParamsValidator
}
