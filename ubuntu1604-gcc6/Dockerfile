FROM ubuntu:16.04

ENV LC_ALL=C DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install apt-utils software-properties-common -y && \
  add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  apt-get dist-upgrade -y && \
  apt-get install -y \
    ccache \
    gcc-6 \
    g++-6 \
    git \
    curl \
    python-pip \
    python3-pip \
    libfontconfig1

RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 50 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-6 50 && \
    update-alternatives --install /usr/bin/cpp cpp /usr/bin/gcc-6 50 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 50 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-6 50

RUN addgroup --gid 1000 iojs && \
  adduser --gid 1000 --uid 1000 --disabled-password --home /home/iojs --shell /bin/bash --gecos iojs iojs

RUN mkdir /home/iojs/tmp

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
