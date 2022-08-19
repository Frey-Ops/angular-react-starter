FROM nginx:1.23.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY  /angular/dist/angular-starter /usr/share/nginx/html
EXPOSE 80
RUN mkdir /run/nginx \
    && chown nginx: /run/nginx /var/cache/nginx
USER nginx
