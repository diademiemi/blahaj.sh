FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

COPY public /var/www/html