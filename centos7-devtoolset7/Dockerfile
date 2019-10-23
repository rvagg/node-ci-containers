FROM centos/devtoolset-7-toolchain-centos7

USER root

RUN yum upgrade -y && \
  yum install -y epel-release && \
  yum install -y \
    which \
    curl \
    git \
    make \
    python2-pip \
    python3-pip \
    ccache

RUN ln -s /usr/bin/ccache /usr/lib64/ccache/c++ && \
  ln -s /usr/bin/ccache /usr/lib64/ccache/cc && \
  ln -s /usr/bin/ccache /usr/lib64/ccache/g++ && \
  ln -s /usr/bin/ccache /usr/lib64/ccache/gcc

RUN groupadd --gid 1000 iojs && \
  useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash iojs

RUN mkdir /home/iojs/tmp

VOLUME /home/iojs/.ccache /home/iojs/workspace

# PATH is also modified by scl_enable and custom_scl_enable.sh
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

COPY custom_scl_enable.sh /opt/app-root/etc/scl_enable

WORKDIR /home/iojs

USER iojs:iojs
