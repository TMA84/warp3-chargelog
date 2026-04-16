ARG BUILD_FROM=ghcr.io/hassio-addons/base:16.3.2
FROM ${BUILD_FROM}

RUN apk add --no-cache nodejs npm

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --production
COPY server.js simplepdf.js warp_logo.png ./
COPY views/ views/

COPY run.sh /etc/s6-overlay/s6-rc.d/warp3/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/warp3/run \
    && echo "longrun" > /etc/s6-overlay/s6-rc.d/warp3/type \
    && touch /etc/s6-overlay/s6-rc.d/user/contents.d/warp3
