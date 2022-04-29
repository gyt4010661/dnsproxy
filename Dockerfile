FROM golang:1.12-stretch AS builder

ADD . ./dnsproxy -l 127.0.0.1 -p 5353 -u 8.8.8.8:53 -u 1.1.1.1:53 -u tls://dns.adguard.com --all-servers

RUN cd /dnsproxy && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo . && strip ./dnsproxy

FROM scratch

COPY --from=builder /dnsproxy/dnsproxy .

entrypoint ["./dnsproxy]
