# --- Build stage (use current LTS) ---
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build   # -> /app/out

# --- Runtime stage (pinned, patched, non-root) ---
FROM nginx:1.27-alpine3.20

# Security + non-root setup
# - listen on 3000 (non-privileged)
# - hide server tokens
# - ensure nginx user can access needed paths
RUN sed -i 's/listen       80;/listen 3000;/' /etc/nginx/conf.d/default.conf \
    && sed -i 's/# server_tokens off;/server_tokens off;/' /etc/nginx/nginx.conf \
    && chown -R nginx:nginx /var/cache/nginx /var/run /etc/nginx/conf.d

# Static files
COPY --from=builder /app/out /usr/share/nginx/html

EXPOSE 3000

# Drop privileges
USER nginx

# Optional healthcheck (Coolify can use it)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
    CMD wget -qO- http://127.0.0.1:3000/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
