# build stage
FROM golang:alpine AS build-env
RUN apk add --update make git
ENV GOPATH /go
WORKDIR /go/src/github.com/digitalocean/bind_exporter
ADD . .
RUN make

# final stage
FROM alpine:3.6
WORKDIR /app
COPY --from=build-env /go/src/github.com/digitalocean/bind_exporter/bind_exporter /app/
ENTRYPOINT ["/app/bind_exporter"]
