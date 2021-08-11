```text
https://jwt.io/ 选rs256填入公私钥
{
  "sub": "1234567890",
  "name": "John Doe",
  "iat": 1516239022,
  "iss": "user@fyxemmmm.cn"
}
签发者必须和yaml文件里的一致
然后在请求的时候带上bearer jwt的token 即可

options请求直接返回204即可
```