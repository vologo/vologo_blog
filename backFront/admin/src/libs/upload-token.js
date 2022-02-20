const qiniu = require('qiniu')
// 自己可以到"www.qiniu.com" 申请自己的七牛空间
// 这个账号是我的，不是开放的哦
const ACCESS_KEY = "dEto3CyrUUqwb78PdCOlFB7Iv_GOxkgAZEMxgPjH";
const SECRET_KEY = "rXrlmW7FPKkrykDfEZjwNwxuPRSFCPetKnDj-wtY";
// 定义生成token的函数
export default async function getUploadToken () {
  // 返回一个promise ，promise 三个状态resolve 成功 reject 失败 pending 待定
  return new Promise((resolve, reject) => {
    // 生成七牛云鉴权对象mac
    let mac = new qiniu.auth.digest.Mac(ACCESS_KEY, SECRET_KEY);
    // 自定义参数
    let options = {
      // 这里填写创建的七牛云的空间名称
      scope: "vologo-blog-pic",
      //自定义凭证有效期（示例2小时，expires单位为秒，为上传凭证的有效时间）
      expires: 7200
    };
    // 七牛云的token生成器实例
    let putPolicy = new qiniu.rs.PutPolicy(options);
    // 生成token
    let uploadToken = putPolicy.uploadToken(mac);

    if (uploadToken) {
      // 如果有值则返回 token对象
      resolve({
        token: uploadToken
      })
    } else {
      // 返回失败
      reject()
    }
  })
}

