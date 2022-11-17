FROM golang:bullseye AS builder

WORKDIR /build

RUN apt update && apt install -y git sqlite3

RUN git clone https://github.com/oxtyped/gpodder2go \
    && cd gpodder2go \
    && go build -o gpodder2go

FROM debian:bullseye-slim

WORKDIR /app

COPY --from=builder /build/gpodder2go/gpodder2go /app/gpodder2go

EXPOSE 3005

CMD ["/app/gpodder2go","serve"]