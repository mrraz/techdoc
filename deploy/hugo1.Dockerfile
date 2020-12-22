FROM alpine:3.12 as build

ARG DOCKER_HUGO_VERSION="0.79.1"
ENV DOCKER_HUGO_NAME="hugo_extended_${DOCKER_HUGO_VERSION}_Linux-64bit"
ENV DOCKER_HUGO_BASE_URL="https://github.com/gohugoio/hugo/releases/download"
ENV DOCKER_HUGO_URL="${DOCKER_HUGO_BASE_URL}/v${DOCKER_HUGO_VERSION}/${DOCKER_HUGO_NAME}.tar.gz"
ENV DOCKER_HUGO_CHECKSUM_URL="${DOCKER_HUGO_BASE_URL}/v${DOCKER_HUGO_VERSION}/hugo_${DOCKER_HUGO_VERSION}_checksums.txt"
ARG INSTALL_NODE="true"

#WORKDIR /build
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache --virtual .build-deps wget && \
    apk add --no-cache \
    git \
    bash \
    make \
    ca-certificates \
    libc6-compat \
    libstdc++ && \
    wget --quiet "${DOCKER_HUGO_URL}" && \
    wget --quiet "${DOCKER_HUGO_CHECKSUM_URL}" && \
    grep "${DOCKER_HUGO_NAME}.tar.gz" "./hugo_${DOCKER_HUGO_VERSION}_checksums.txt" | sha256sum -c - && \
    tar -zxvf "${DOCKER_HUGO_NAME}.tar.gz" && \
    mv ./hugo /hugo && \
    /hugo version && \
    apk del .build-deps

RUN apk add --update nodejs npm && \
    echo "path pwd: $(pwd)" && \
    echo "path ls: $(ls)" && \
    npm install -g  postcss postcss-cli && \
    npm install autoprefixer && \
    echo "path pwd: $(pwd)" && \
    echo "path ls: $(ls /node_modules)"


ENTRYPOINT [ "/hugo" ]
