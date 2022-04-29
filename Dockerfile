FROM golang:1.12-stretch AS builder

ADD . /dnsproxy

RUN cd /dnsproxy && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo . && strip ./dnsproxy -u sdns://AgcAAAAAAAAABzEuMC4wLjGgENk8mGSlIfMGXMOlIlCcKvq7AVgcrZxtjon911-ep0cg63Ul-I8NlFj4GplQGb_TTLiczclX57DvMV8Q-JdjgRgSZG5zLmNsb3VkZmxhcmUuY29tCi9kbnMtcXVlcnk

FROM scratch

COPY --from=builder /dnsproxy/dnsproxy .

entrypoint ["./dnsproxy]
