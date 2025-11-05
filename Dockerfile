# ---- Build static site ----
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
ENV NEXT_TELEMETRY_DISABLED=1

# Next 14 with output:'export' -> writes to /app/out
RUN npm run build

# ---- Nginx to serve the static export ----
FROM nginx:1.27-alpine3.20

# Replace default nginx.conf to log to stdout/stderr and run in foreground
RUN cat > /etc/nginx/nginx.conf <<'NGINXCONF'
user  nginx;
worker_processes  auto;

error_log  /dev/stderr info;
pid        /var/run/nginx.pid;

events { worker_connections  1024; }

http {
  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;

  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';
  access_log  /dev/stdout  main;

  sendfile        on;
  keepalive_timeout  65;

  include /etc/nginx/conf.d/*.conf;
}
NGINXCONF

# Minimal server on :3000 with SPA fallback
RUN mkdir -p /usr/share/nginx/html && \
  cat > /etc/nginx/conf.d/default.conf <<'SERVER'
server {
  listen 3000;
  server_name _;

  root /usr/share/nginx/html;
  index index.html;

  location / {
    try_files $uri $uri/ /index.html;
  }

  location ~* \.(js|css|png|jpg|jpeg|gif|svg|ico|woff2?)$ {
    add_header Cache-Control "public, max-age=31536000, immutable";
    try_files $uri =404;
  }
}
SERVER

# Copy static export from the builder
COPY --from=builder /app/out/ /usr/share/nginx/html/

# Expose the internal port that Coolify maps (4010:3000)
EXPOSE 3000

# Run nginx in foreground (no custom healthcheck needed)
CMD ["nginx", "-g", "daemon off;"]
