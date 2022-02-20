const {
  Rule,
  LinValidator
} = require('../../core/lin-validator-v2')

class ImageValidator extends LinValidator {
  constructor() {
    super()
    // this.is_collected = [new Rule("isLength", "素材 is_collected 是否收藏不能为空", {min: 1})]
    this.url = [new Rule("isLength", "素材链接 url 不能为空", {min: 1})]
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
  ImageValidator,
  PositiveIdParamsValidator
}
