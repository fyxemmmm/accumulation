FROM golang:1.14-alpine as builder

# privaite repo go module
#RUN apk add --no-cache git openssh-client
#ARG	GITHUB_USER
#ARG	GITHUB_TOKEN
# docker build --build-arg GITHUB_USER=$$GITHUB_USER --build-arg GITHUB_TOKEN=$$GITHUB_TOKEN -t $(REPO_NAME):$$ENV .
#RUN echo "machine github.com login ${GITHUB_USER} password ${GITHUB_TOKEN}" > ~/.netrc

WORKDIR /my_test_folder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o build/mytest ./main.go

FROM alpine
COPY --from=builder /my_test_folder/build/ /
ENTRYPOINT "./mytest"