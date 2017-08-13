FROM "node:alpine"

ARG BUILD_PACKAGES="git"
ARG DEV_PACKAGES="gcc g++ make cmake"

RUN apk add --no-cache \
        ${BUILD_PACKAGES} \
        ${DEV_PACKAGES}

RUN npm install -g \
        eslint eslint-config-airbnb \
        tslint typescript

CMD ["node"]
