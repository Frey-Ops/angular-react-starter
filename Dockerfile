FROM node:alpine3.15 as react

WORKDIR /react

COPY ./react/package* ./

# For fix noticy about update npm. If you want to fix that, delete '#' in start next line.
#RUN npm install -g npm@8.15.0

RUN npm install

COPY ./react .
RUN npm run build

FROM node:alpine3.15 as angular

WORKDIR /angular

COPY ./angular/package* ./

RUN npm install

COPY ./angular .
RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=react /react/build /usr/share/nginx/html/react
COPY --from=angular /angular/dist/angular-starter /usr/share/nginx/html
EXPOSE 80 3000
CMD ["nginx", "-g", "daemon off;"]
