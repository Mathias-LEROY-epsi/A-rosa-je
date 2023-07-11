# Étape 1 : Builder l'application Vue.js
FROM node:lts-alpine AS builder
WORKDIR /app
COPY client/package*.json ./
RUN npm install
COPY client .
RUN npm run build

# Étape 2 : Exécuter l'application sur NGINX
FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Copier la configuration NGINX personnalisée et les certificats SSL
COPY nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir /etc/nginx/ssl
COPY nginx/certificate.crt /etc/nginx/ssl/certificate.crt
COPY nginx/private.key /etc/nginx/ssl/private.key

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
