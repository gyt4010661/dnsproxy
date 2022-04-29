FROM golang:1.12-stretch AS builder

ADD . /dnsproxy

RUN cd /dnsproxy && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo . && strip ./dnsproxy -l 127.0.0.1 --https-port=443 --tls-crt=example.crt --tls-key=example.key -u 8.8.8.8:53 -p 0 

FROM scratch

COPY --from=builder /dnsproxy/dnsproxy .

entrypoint ["./dnsproxy]
