FROM ubuntu:18.04

ENV LC_ALL C
ENV USER iojs
ENV JOBS 4
ENV SHELL /bin/bash
ENV HOME /home/iojs
ENV PATH /usr/lib/ccache/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV NODE_COMMON_PIPE /home/iojs/test.pipe
ENV NODE_TEST_DIR /home/iojs/tmp
ENV OSTYPE linux-gnu
ENV OSVARIANT docker
ENV DESTCPU x64
ENV ARCH x64
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install apt-utils -y \
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

RUN pip install tap2junit && pip3 install tap2junit

RUN addgroup --gid 1000 iojs && adduser --gid 1000 --uid 1000 --disabled-password --gecos iojs iojs

VOLUME /home/iojs/.ccache /home/iojs/workspace

USER iojs:iojs
