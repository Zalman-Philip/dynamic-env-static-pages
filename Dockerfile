FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
COPY tsconfig*.json ./

RUN npm i 

COPY ./src ./src
COPY ./public ./public

COPY index.html ./
COPY vite.config.ts ./

RUN npm run build && npm cache clean --force

FROM nginx:alpine

RUN apk update
RUN apk upgrade
RUN apk add bash

COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/src/nginx/default.conf /etc/nginx/conf.d/default.conf

COPY env.sh /docker-entrypoint.d

RUN chmod +x /docker-entrypoint.d/env.sh

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.d/env.sh"]
CMD ["nginx", "-g", "daemon off;"]