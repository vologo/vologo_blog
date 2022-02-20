const {
  Rule,
  LinValidator
} = require('../../core/lin-validator-v2')

class FriendValidator extends LinValidator {
  constructor() {
    super()
    this.name = [
      new Rule("isLength", "友链名称 name 不能为空", {min: 1})
    ]
    this.link = [
      new Rule("isLength", "友链链接 link 不能为空", {min: 1})
    ]
    this.avatar = [
      new Rule("isLength", "友链头像 avatar 不能为空", {min: 1})
    ]
    this.description = [
      new Rule("isLength", "友链链接 description 不能为空", {min: 1})
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
  FriendValidator,
  PositiveArticleIdParamsValidator
}
