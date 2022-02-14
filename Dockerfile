FROM golang:1.16-alpine AS multistage

RUN apk add --no-cache --update git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN go mod init main

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /main

FROM scratch
COPY --from=multistage /main /
CMD ["/main"]
