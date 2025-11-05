# ---- Build static site ----
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
ENV NEXT_TELEMETRY_DISABLED=1

# Next 14: output:'export' makes /app/out at build time
RUN npm run build

# ---- Minimal Nginx server ----
FROM nginx:1.27-alpine3.20

# Clean pid line and serve on :3000
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

  location ~* \.(js|css|png|jpg|jpeg|gif|svg|ico|woff2?)$ {
    add_header Cache-Control "public, max-age=31536000, immutable";
    try_files $uri =404;
  }
}
NGINX

# Copy static export from builder
COPY --from=builder /app/out/ /usr/share/nginx/html/

RUN chown -R nginx:nginx /var/cache/nginx /var/run /etc/nginx /usr/share/nginx
USER nginx

EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=3s --retries=5 CMD wget -qO- http://127.0.0.1:3000/ >/dev/null 2>&1 || exit 1
CMD ["nginx", "-g", "daemon off;"]
