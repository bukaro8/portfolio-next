# ---- Build static site ----
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build 

# ---- Minimal Nginx server (no duplicate pid) ----
FROM nginx:1.27-alpine3.20

# Remove 'pid' directive and write a simple server config listening on 3000
RUN sed -i '/^[[:space:]]*pid[[:space:]]\+/d' /etc/nginx/nginx.conf && \
  mkdir -p /usr/share/nginx/html && \
  cat > /etc/nginx/conf.d/default.conf <<'NGINX'
server {
  listen 3000;
  server_name _;
  root /usr/share/nginx/html;
  index index.html;

  location / {
    try_files $uri $uri/ /index.html;
  }

  # Basic static caching
  location ~* \.(js|css|png|jpg|jpeg|gif|svg|ico|woff2?)$ {
    add_header Cache-Control "public, max-age=31536000, immutable";
    try_files $uri =404;
  }
}
NGINX

# Copy static export
COPY --from=builder /app/out/ /usr/share/nginx/html/

# Permissions + non-root
RUN chown -R nginx:nginx /var/cache/nginx /var/run /etc/nginx /usr/share/nginx
USER nginx

EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=3s --retries=5 CMD wget -qO- http://127.0.0.1:3000/ >/dev/null 2>&1 || exit 1
CMD ["nginx", "-g", "daemon off;"]
