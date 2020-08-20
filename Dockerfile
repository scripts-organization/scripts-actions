### STAGE 1: Build ###
FROM node:14.4.0-alpine AS build
WORKDIR /usr/src/app
COPY package.json yarn.lock rappid-3.2.0.tgz ./
RUN yarn install

COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist /usr/share/nginx/html