package apiOrder

//go:generate protoc -I. --go_out=plugins=grpc,paths=source_relative:. api_order.proto

// gw -> go:generate protoc -I. -I${GOPATH}/src -I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --go_out=plugins=grpc,paths=source_relative:. --grpc-gateway_out=logtostderr=true,paths=source_relative:. public.proto