FROM ubuntu:18.04

ENV LC_ALL=C DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install apt-utils -y && \
  apt-get dist-upgrade -y && \
  apt-get install -y \
    ccache \
    g++ \
    gcc \
    git \
    curl \
    python-pip \
    python3-pip \
    libfontconfig1

# Installing ccache doesn't do this for us on Ubuntu but these are
# the defaults that `ninja` uses so it bypasses ccache without these
RUN ln -sf /usr/bin/ccache /usr/lib/ccache/cc && \
  ln -sf /usr/bin/ccache /usr/lib/ccache/c++

RUN addgroup --gid 1000 iojs && \
  adduser --gid 1000 --uid 1000 --disabled-password --home /home/iojs --shell /bin/bash --gecos iojs iojs

RUN su iojs -c 'mkdir /home/iojs/tmp'

ENV ZLIB12DIR /opt/zlib_1.2.11

RUN mkdir -p /tmp/zlib_1.2.11 && \
    cd /tmp/zlib_1.2.11 && \
    curl -sL https://zlib.net/zlib-1.2.11.tar.gz | tar zxv --strip=1 && \
    ./configure --prefix=$ZLIB12DIR && \
    make -j 6 && \
    make install && \
    rm -rf /tmp/zlib_1.2.11

VOLUME /home/iojs/.ccache /home/iojs/workspace

ENV PATH=/usr/lib/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
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
