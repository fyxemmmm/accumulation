### 自签ca及颁发证书 方式二


- 1. 自签ca
    - cd /etc/pki/CA
    - (umask 077;openssl genrsa -out private/cakey.pem 4096)
    - openssl req -new -x509 -key private/cakey.pem -out cacert.pem -days 3650
    - 查看证书信息： openssl x509 -in cacert.pem -noout -text
    - 添加数据库文件： touch /etc/pki/CA/index.txt 
    - 添加序号文件： touch /etc/pki/CA/serial && echo 0F > /etc/pki/CA/serial
  2. 客户端申请证书  
    - (umask 066; openssl genrsa -out app.key 1024)
    - openssl req -new -key app.key -out app.csr
  3. ca颁发证书
    - openssl ca -in /root/app.csr -out certs/app.crt -days 365
- 注意：
    #### ca颁发证书的时候，是在服务端的宿主机上，所以默认读取的配置文件是在/etc/pki/tls/openssl.cnf
    #### /etc/pki/CA/index.txt.attr 记得设置成no， 为了方便颁发相同的证书，解决续期问题，默认不让颁发相同的csr发出的证书请求

---
#### 其他
查看证书有效性
###### openssl ca -status 0F

查看证书的有效期
###### openssl x509 -in app.crt -noout -dates
