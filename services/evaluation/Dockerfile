# Stage 1: Builder
# golang:1.25-alpine corrige CVE-2025-68121 (crypto/tls — fix em 1.24.13/1.25.7)
FROM golang:1.25-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o evaluation-service .

# Stage 2: Runtime (sem Go, imagem minima)
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/evaluation-service .
EXPOSE 8004
CMD ["./evaluation-service"]
