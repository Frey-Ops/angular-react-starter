FROM node:alpine3.15 as angular
WORKDIR /angular
COPY ./angular/package* ./
COPY ./angular .
RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=angular /angular/dist/angular-starter /usr/share/nginx/html
EXPOSE 80
RUN mkdir /run/nginx \
    && chown nginx: /run/nginx /var/cache/nginx
USER nginx
