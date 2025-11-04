# --- Runtime stage (static Nginx, non-root, secure) ---
FROM nginx:1.27-alpine3.20

# Listen on 3000, hide tokens, fix perms, and write PID in /tmp
RUN sed -i 's/listen       80;/listen 3000;/' /etc/nginx/conf.d/default.conf \
    && sed -i 's/# server_tokens off;/server_tokens off;/' /etc/nginx/nginx.conf \
    && sed -i '1s;^;pid /tmp/nginx.pid;\n;' /etc/nginx/nginx.conf \
    && chown -R nginx:nginx /var/cache/nginx /var/run /etc/nginx/conf.d /var/log/nginx /tmp

COPY --from=builder /app/out /usr/share/nginx/html

EXPOSE 3000
USER nginx
CMD ["nginx", "-g", "daemon off;"]
