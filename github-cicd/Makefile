sha1Short=$(shell git rev-parse --short HEAD)
appName=user-activity
docker-push:
	docker build --build-arg GITHUB_USER=$$GITHUB_USER --build-arg GITHUB_TOKEN=$$GITHUB_TOKEN -t ankrnetwork/$(appName):$(sha1Short) .
	docker push ankrnetwork/$(appName):$(sha1Short)
	docker tag ankrnetwork/$(appName):$(sha1Short) ankrnetwork/$(appName):latest
	docker push ankrnetwork/$(appName):latest

.PHONY: proto
proto:
	@for t in changelog/v1alpha; do \
    	protoc -Iapi/protos -I${GOPATH}/src -I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    		-I ${GOPATH}/src/github.com/envoyproxy/protoc-gen-validate \
    		--go_out=plugins=grpc:api/protos --validate_out=lang=go:api/protos api/protos/$$t/*.proto; \
    	if ls api/protos/$$t/public*.proto 1> /dev/null 2>&1;  then protoc -Iapi/protos -I${GOPATH}/src -I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    		-I ${GOPATH}/src/github.com/envoyproxy/protoc-gen-validate \
        	--grpc-gateway_out=logtostderr=true:api/protos --swagger_out=logtostderr=true:api/protos \
        	 api/protos/$$t/public*.proto; fi \
	done
