## 生成证书
```shell
# 先下载好工具
wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 cfssl-certinfo_linux-amd64
mv cfssl_linux-amd64 /usr/local/bin/cfssl
mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
mv cfssl-certinfo_linux-amd64 /usr/bin/cfssl-certinfo


# 证书1
vi ca-config.json  
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "server": {
        "usages": ["signing"],
        "expiry": "8760h"
      }
    }
  }
}

# 证书2
vi ca-csr.json  
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "zh",
      "L": "bj",
      "O": "bj",
      "OU": "CA"
   }
  ]
}

# 生成ca证书
cfssl gencert -initca ca-csr.json | cfssljson -bare ca

# 服务端证书csr
vi server-csr.json
{
  "CN": "admission",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "zh",
      "L": "bj",
      "O": "bj",
      "OU": "bj"
    }
  ]
}


# 签发证书  hostname非常重要
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=myhook.kube-system.svc \
  -profile=server \
  server-csr.json | cfssljson -bare server


#caBundle的内容这么取：
cat ca.pem | base64

# k8s创建密文
kubectl create secret tls myhook --cert=server.pem --key=server-key.pem  -n kube-system
```