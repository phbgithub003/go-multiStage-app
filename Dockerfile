
FROM golang:1.23 AS builder

WORKDIR /app

COPY main.go .


RUN go mod init main.go

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o app .


FROM alpine

WORKDIR /


COPY --from=builder /app/app .


EXPOSE 8080


ENTRYPOINT ["./app"]
