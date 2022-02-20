const {
  Rule,
  LinValidator
} = require('../../core/lin-validator-v2')

class TagValidator extends LinValidator {
  constructor() {
    super()
    this.name = [new Rule("isLength", "标签 name 名字不能为空", {min: 1})]
    this.key = [new Rule("isLength", "标签关键字 key 不能为空", {min: 1})]
    this.color = [new Rule("isLength", "标签颜色 color 不能为空", {min: 1})]
  }
}

class PositiveIdParamsValidator extends LinValidator {
  constructor() {
    super();
    this.id = [
      new Rule('isInt', '标签ID需要正整数', {min: 1})
    ]
  }
}

module.exports = {
  TagValidator,
  PositiveIdParamsValidator
}
