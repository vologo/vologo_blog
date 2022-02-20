const qiniu = require('qiniu')

// 自己可以到"www.qiniu.com" 申请自己的七牛空间
// 这个账号是我的，不是开放的哦
const ACCESS_KEY = "dEto3CyrUUqwb78PdCOlFB7Iv_GOxkgAZEMxgPjH";
const SECRET_KEY = "rXrlmW7FPKkrykDfEZjwNwxuPRSFCPetKnDj-wtY";

// export default async function getUploadToken () {
const getUploadToken =  async()=> {
  
  return new Promise((resolve, reject) => {
    let mac = new qiniu.auth.digest.Mac(ACCESS_KEY, SECRET_KEY);
    let options = {
      // 这里填写创建的七牛云的空间名称
      scope: "vologo-blog-pic",
      expires: 7200
    };
    let putPolicy = new qiniu.rs.PutPolicy(options);
    let uploadToken = putPolicy.uploadToken(mac);

    if (uploadToken) {
      resolve({
        token: uploadToken
      })
    } else {
      reject()
    }
  })
}
module.exports = {
  getUploadToken
}