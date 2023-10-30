FROM node:20.9.0-slim as builder
WORKDIR /app
COPY package.json .
COPY package-lock.json .
# COPY public/ ./public
# COPY src/ ./src
# COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.19.0-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]