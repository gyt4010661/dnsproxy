FROM golang:1.12-stretch AS builder

ADD  ./dnsproxy -u 8.8.8.8:53

RUN cd /dnsproxy && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo . && strip ./dnsproxy

FROM scratch

COPY --from=builder /dnsproxy/dnsproxy .

entrypoint ["./dnsproxy]
