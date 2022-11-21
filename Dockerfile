FROM golang:bullseye AS builder

WORKDIR /build

RUN apt update && apt install -y git sqlite3

COPY . .

RUN go build -o gpodder2go

FROM debian:bullseye-slim

WORKDIR /app

RUN apt-get update && apt-get install -y procps

COPY --from=builder /build/gpodder2go /app/gpodder2go

COPY ./migrations /app/migrations

COPY ./docker_entrypoint.sh /app/docker_entrypoint.sh

EXPOSE 3005

ENTRYPOINT [ "/app/docker_entrypoint.sh" ]