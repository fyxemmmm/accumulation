SHELL = /bin/bash

REPO_NAME ?= myreponame

.PHONY: vet
vet:
	@go vet ./...

.PHONY: test
test: vet
	@go test -test.v ./...

.PHONY: proto
proto:
	@protoc -Iapi/protos -I${GOPATH}/src -I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		-I ${GOPATH}/src/github.com/envoyproxy/protoc-gen-validate \
		--go_out=plugins=grpc:api/protos --validate_out=lang=go:api/protos \
		--grpc-gateway_out=logtostderr=true:api/protos api/protos/v1alpha/common/*.proto
	@for t in v1alpha/invoice v1alpha/payment v2alpha/payment; do \
    	protoc -Iapi/protos -I${GOPATH}/src -I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    		-I ${GOPATH}/src/github.com/envoyproxy/protoc-gen-validate \
    		--go_out=plugins=grpc,Mv1alpha/common/type.proto=github.com/Ankr-network/billmgr/api/protos/v1alpha/common:api/protos \
    		--validate_out=lang=go,Mv1alpha/common/type.proto=github.com/Ankr-network/billmgr/api/protos/v1alpha/common:api/protos api/protos/$$t/*.proto; \
    	if ls api/protos/$$t/public*.proto 1> /dev/null 2>&1;  then protoc -Iapi/protos -I${GOPATH}/src -I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    		-I ${GOPATH}/src/github.com/envoyproxy/protoc-gen-validate \
        	--grpc-gateway_out=logtostderr=true,Mv1alpha/common/type.proto=github.com/Ankr-network/billmgr/api/protos/v1alpha/common:api/protos \
        	--swagger_out=logtostderr=true,Mv1alpha/common/type.proto=github.com/Ankr-network/billmgr/api/protos/v1alpha/common:api/protos \
        	 api/protos/$$t/public*.proto; fi \
	done



# Deprecated
.PHONY: docker-build
docker-build:
	@echo "build docker image"
	@BRANCH_NAME=$(shell git rev-parse --abbrev-ref HEAD); \
	if [[ $$BRANCH_NAME == "develop" ]]; then \
		ENV="stage"; \
	elif [[ $$BRANCH_NAME == "master" ]]; then \
		ENV="prod"; \
	else \
		ENV="feat"; \
	fi; \
	docker build --build-arg GITHUB_USER=$$GITHUB_USER --build-arg GITHUB_TOKEN=$$GITHUB_TOKEN -t $(REPO_NAME):$$ENV .

# Deprecated
.PHONY: docker-push
docker-push: docker-build
	@echo "tag & push image"
	@BRANCH_NAME=$(shell git rev-parse --abbrev-ref HEAD); SHA1_SHORT=$(shell git rev-parse --short HEAD); DATE=$(shell date +%Y%m%d%H%M%S); \
	if [[ $$BRANCH_NAME == "develop" ]]; then \
		ENV="stage"; \
	elif [[ $$BRANCH_NAME == "master" ]]; then \
		ENV="prod"; \
	else \
		ENV="feat"; \
	fi;  \
	for TAG in $$ENV $$SHA1_SHORT $$ENV$$DATE; do \
		docker tag $(REPO_NAME):$$ENV ankrnetwork/$(REPO_NAME):$$TAG; \
		docker push ankrnetwork/$(REPO_NAME):$$TAG; \
	done

