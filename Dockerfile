# --- Build stage ---
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build   # outputs /app/out

# --- Runtime stage ---
FROM nginx:alpine
COPY --from=builder /app/out /usr/share/nginx/html
EXPOSE 3000
CMD ["sh", "-c", "sed -i 's/listen       80;/listen 3000;/' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
