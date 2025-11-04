# --- Build stage: create static export in /app/out ---
FROM node:20-alpine AS builder
WORKDIR /app

# Install deps (keep dev deps for Next build)
COPY package*.json ./
RUN npm ci

# Copy source and build (requires next.config.mjs with output: 'export')
COPY . .
# Optional but recommended for static images when exporting:
# ensure next.config.mjs has:  export default { output: 'export', images: { unoptimized: true } }
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build     # produces /app/out

# --- Runtime stage: serve static with Nginx on 3000, non-root ---
FROM nginx:1.27-alpine3.20

# Listen on 3000 and hide server tokens
RUN sed -i 's/listen\s*80;/listen 3000;/' /etc/nginx/conf.d/default.conf \
    && sed -i 's/# server_tokens off;/server_tokens off;/' /etc/nginx/nginx.conf \
    && chown -R nginx:nginx /var/cache/nginx /var/run /etc/nginx/conf.d /var/log/nginx /tmp

# Copy static export
COPY --from=builder /app/out/ /usr/share/nginx/html

EXPOSE 3000
USER nginx
# Set PID via -g so /tmp is writable by non-root
CMD ["nginx", "-g", "pid /tmp/nginx.pid; daemon off;"]
