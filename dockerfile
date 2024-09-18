FROM golang:latest AS builder

WORKDIR /app

COPY app .
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -o binary

FROM alpine

COPY --from=builder /app/binary /
COPY --from=builder /app/tracker.db /
CMD ["/binary"]