FROM node:15.5.1-alpine3.11 AS build

ENV CHOKIDAR_USEPOLLING=1

ADD . /app
WORKDIR /app

RUN ls /app

RUN npm install
RUN npm run build

FROM nginx:alpine

COPY --from=build /app/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/* /usr/share/nginx/html/
