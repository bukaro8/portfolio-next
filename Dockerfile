# --- Build stage ---
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
# next.config.mjs must have: export default { output: 'export' }
RUN npm run build   # produces /app/out

# --- Runtime stage (static Nginx, non-root) ---
FROM nginx:1.27-alpine3.20
# Listen on 3000, hide tokens, write PID to /tmp
RUN sed -i 's/listen       80;/listen 3000;/' /etc/nginx/conf.d/default.conf \
    && sed -i 's/# server_tokens off;/server_tokens off;/' /etc/nginx/nginx.conf \
    && sed -i '1s;^;pid /tmp/nginx.pid;\n;' /etc/nginx/nginx.conf \
    && chown -R nginx:nginx /var/cache/nginx /var/run /etc/nginx/conf.d /var/log/nginx /tmp
COPY --from=builder /app/out /usr/share/nginx/html
EXPOSE 3000
USER nginx
CMD ["nginx", "-g", "daemon off;"]
