FROM --platform=linux/amd64 rust:alpine3.17 as builder
RUN apk add --no-cache --update musl-dev libc-dev clang-dev && \
    rm -rf /var/cache/apk/*
ENV RUSTFLAGS="-C target-feature=-crt-static"
ENV USER root
WORKDIR is-even-api
COPY . .
RUN cargo build --release

FROM --platform=linux/amd64 alpine:latest
EXPOSE 8000
RUN apk add --no-cache --update musl-dev libc-dev clang-dev && \
    rm -rf /var/cache/apk/*
COPY --from=builder /is-even-api/target/release/is-even-api /is-even-api 
CMD ["/is-even-api"]
