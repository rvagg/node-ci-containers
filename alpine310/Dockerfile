FROM alpine:3.10

ENV LC_ALL C

RUN apk add --no-cache --upgrade apk-tools && \
  apk add --no-cache libstdc++ && \
  apk add --no-cache --virtual .build-deps \
        shadow \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        paxctl \
        python \
        python3 \
        py2-pip \
        py3-pip \
        tar \
        ccache \
        openjdk8 \
        git \
        procps \
        openssh-client \
        bash \
        automake \
        libtool \
        autoconf

RUN addgroup -g 1000 iojs && adduser -G iojs -D -u 1000 iojs

VOLUME /home/iojs/.ccache /home/iojs/workspace

ENV PATH=/usr/lib/ccache/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  USER=iojs \
  JOBS=2 \
  SHELL=/bin/bash \
  HOME=/home/iojs \
  NODE_COMMON_PIPE=/home/iojs/test.pipe \
  NODE_TEST_DIR=/home/iojs/tmp \
  OSTYPE=linux-gnu \
  OSVARIANT=docker \
  DESTCPU=x64 \
  ARCH=x64

WORKDIR /home/iojs

USER iojs:iojs
