FROM golang:1.14-alpine AS compiler

RUN apk add --no-cache git openssh-client

ARG GITHUB_USER
ARG GITHUB_TOKEN
RUN echo "machine github.com login ${GITHUB_USER} password ${GITHUB_TOKEN}" > ~/.netrc

WORKDIR /go/src/app
COPY ./ ./
RUN pwd
RUN ls

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .
RUN ls

FROM alpine:latest
RUN apk --no-cache add tzdata ca-certificates
WORKDIR /root/
RUN pwd
COPY --from=compiler /go/src/app/app /root/app
RUN ls
ENTRYPOINT ["/root/app/aci-court"]