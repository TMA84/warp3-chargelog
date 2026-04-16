ARG BUILD_FROM=ghcr.io/hassio-addons/base:16.3.2
FROM ${BUILD_FROM}

RUN apk add --no-cache nodejs npm

COPY package.json package-lock.json /app/
RUN cd /app && npm ci --production
COPY server.js simplepdf.js warp_logo.png /app/
COPY views/ /app/views/

COPY rootfs /

WORKDIR /
