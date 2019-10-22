FROM fedora:30

RUN dnf -y update && \
  dnf clean all && \
  dnf -y install \
    bzip2 \
    which \
    findutils \
    procps \
    ccache \
    gcc-c++ \
    git \
    fontconfig \
    make \
    curl \
    python-pip \
    python3-pip

RUN groupadd --gid 1000 iojs && \
  useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash iojs

VOLUME /home/iojs/.ccache /home/iojs/workspace

ENV PATH=/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
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
