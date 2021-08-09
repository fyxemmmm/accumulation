#### gitea设置
```text
ssh服务域名填写机器的ip
ssh服务端口填写gitea的ssh端口, 如果是nodePort, 就填写其端口
基础url = 机器ip + web端口, nodePort暴露的web端口
```

---
#### 创建拉取镜像的secret
```text
创建拉取镜像的secret(如果要拉取私有镜像)
kubectl create secret docker-registry regsecret --docker-server=registry.cn-shanghai.aliyuncs.com --docker-username=fyxemmmm --docker-password=xxxx  -n cicd
```

#### jenkins设置
```text
输入一个任务名
- 源码管理
    - git的repo url填写gitea的私有仓库的地址
- 添加一个私钥
- 构建里可以执行shell, 可以执行docker info来test测试

webhook需要安装插件, 搜索即可
然后构建触发器里勾选上, token随便填写个, 假设是testtoken
手动触发：http://121.37.156.155:30001/generic-webhook-trigger/invoke?token=testtoken
自动触发需要在gitea的web钩子中填写这个url即可, 提交代码的时候会自动触发web钩子
```
