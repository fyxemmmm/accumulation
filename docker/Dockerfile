FROM golang:1.14-alpine as builder

# privaite repo go module
#RUN apk add --no-cache git openssh-client
#ARG	GITHUB_USER
#ARG	GITHUB_TOKEN
# docker build --build-arg GITHUB_USER=$$GITHUB_USER --build-arg GITHUB_TOKEN=$$GITHUB_TOKEN -t $(REPO_NAME):$$ENV .
#RUN echo "machine github.com login ${GITHUB_USER} password ${GITHUB_TOKEN}" > ~/.netrc

WORKDIR /myapp
COPY . .
RUN  CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o ceph-metrics ./main.go

FROM alpine
WORKDIR /
COPY --from=builder /myapp/*  /
ENTRYPOINT ["/ceph-metrics"]
#CMD ["/ceph-metrics"]