# Use Go 1.23 bookworm as base image
FROM golang:alpine AS base

WORKDIR /build

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o simple-go-project
EXPOSE 9009
CMD ["simple-go-project", "serve"]


FROM alpine:latest
WORKDIR /app
COPY --from=base /build/simple-go-project /app/simple-go-project
CMD ["/app/simple-go-project", "serve"]