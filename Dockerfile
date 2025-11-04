# --- Runtime stage (static Nginx, non-root) ---
FROM nginx:1.27-alpine3.20

# Listen on 3000 and hide server tokens
RUN sed -i 's/listen\s*80;/listen 3000;/' /etc/nginx/conf.d/default.conf \
    && sed -i 's/# server_tokens off;/server_tokens off;/' /etc/nginx/nginx.conf \
    && chown -R nginx:nginx /var/cache/nginx /var/run /etc/nginx/conf.d /var/log/nginx /tmp

# Static site from Next export
COPY --from=builder /app/out /usr/share/nginx/html

EXPOSE 3000
USER nginx

# Set PID location via -g (no need to modify nginx.conf)
CMD ["nginx", "-g", "pid /tmp/nginx.pid; daemon off;"]
