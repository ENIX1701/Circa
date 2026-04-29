FROM node:22-bookworm-slim AS frontend

ARG VITE_AUTH_DELIVERY_MODE=outbox
ENV VITE_AUTH_DELIVERY_MODE=$VITE_AUTH_DELIVERY_MODE

WORKDIR /app/frontend

COPY frontend/package*.json ./

RUN npm ci

COPY frontend/ ./

RUN npm run build

FROM rust:1-bookworm AS backend-builder

WORKDIR /app/backend

RUN apt-get update && apt-get install -y --no-install-recommends pkg-config libssl-dev ca-certificates && rm -rf /var/lib/apt/lists/*

COPY backend/ ./

RUN cargo build --release

FROM debian:bookworm-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates libssl3 && rm -rf /var/lib/apt/lists/*

COPY --from=backend-builder /app/backend/target/release/circa_backend /app/circa_backend
COPY --from=frontend /app/frontend/dist /app/public

ENV APP_ENV=production

CMD ["/app/circa_backend"]
