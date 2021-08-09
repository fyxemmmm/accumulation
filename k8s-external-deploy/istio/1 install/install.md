#### 下载
https://github.com/istio/istio/releases/tag/1.9.0-beta.1

```yaml
安装
  解压缩，让进入bin目录，把bin中的二进制文件拷贝到环境变量中
  istioctl manifest apply --set profile=demo  # 安装istio
  就出现了istio-system名称空间

istio-ingressgateway的service设置成nodePort, http2的端口开放30080的nodePort外网地址

自动注入
kubectl label namespace myistio istio-injection=enabled
（kubectl label namespace myistio istio-injection-   删除标签）
（kubectl get namespace -L istio-injection  查询标签）

访问  http://prods.fyxemmmm.cn:30080/prods/1234
即可出现页面
```

#### 安装kiali可视化界面
```shell
安装kiali
helm install \
  --namespace istio-system \
  --set auth.strategy="token" \
  --repo https://kiali.org/helm-charts \
  kiali-server \
  kiali-server

安装好之后, token获取方式
kubectl -n istio-system describe secret $(kubectl -n  istio-system  get secret | grep kiali | awk '{print $1}')
把token贴入即可

prometheus 用cname的方式指向operator的svc
```