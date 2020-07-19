FROM golang:1.14 AS builder
ENV GO111MODULE=on
WORKDIR /app
COPY ./ /app
RUN go build -o golang-test  .
RUN CGO_ENABLED=0 GOOS=linux go build -a -o golang-test  .

FROM alpine:3.12
RUN apk update --no-cache
WORKDIR /app
COPY --from=builder /app/golang-test .
ENTRYPOINT ["/app/golang-test"]
EXPOSE 8000
