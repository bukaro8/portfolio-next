# --- Build stage: create static export in /app/out ---
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
# ensure next.config.mjs has: export default { output: 'export', images: { unoptimized: true } }
RUN npm run build     # produces /app/out

# --- Runtime stage: serve static with Nginx on 3000, non-root ---
FROM nginx:1.27-alpine3.20

# Listen on 3000 and hide server tokens (no PID tweaks here)
RUN sed -ri 's/listen\s+80;/listen 3000;/' /etc/nginx/conf.d/default.conf \
    && sed -ri 's/# server_tokens off;/server_tokens off;/' /etc/nginx/nginx.conf \
    && chown -R nginx:nginx /var/cache/nginx /var/run /etc/nginx/conf.d /var/log/nginx

# If you still hit a PID warning after this, uncomment the next line to remove any pid directive from nginx.conf
# RUN sed -ri '/^\s*pid\s+/d' /etc/nginx/nginx.conf

COPY --from=builder /app/out/ /usr/share/nginx/html/
EXPOSE 3000
USER nginx
CMD ["nginx","-g","daemon off;"]
