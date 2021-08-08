#### 没有golang环境但是想要使用docker去编译
```shell
docker run --rm -it  \
-v /home/feixiang/istio/pro:/app \
-v /home/feixiang/gopath:/go \
-w /app \
-e CGO_ENABLED=0  \
-e GOPROXY=https://goproxy.cn \
golang:1.15-alpine3.12 \
go build -o build/prods prods.go
```

