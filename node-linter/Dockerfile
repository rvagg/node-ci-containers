FROM node:12-stretch

ENV LC_ALL=C DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install apt-utils -y && \
  apt-get dist-upgrade -y && \
  apt-get install -y \
    make \
    python-pip \
    python3-pip

COPY lint-node.sh /usr/local/bin/lint-node.sh

# node images comes with user 'node' with uid/gid 1000, we need that to be 'iojs'
RUN usermod -l iojs node && \
  groupmod node -n iojs && \
  mkdir -p /home/iojs/workspace && \
  chown iojs:iojs -R /home/iojs/

VOLUME /home/iojs/workspace

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  USER=iojs \
  JOBS=2 \
  SHELL=/bin/bash \
  HOME=/home/iojs

WORKDIR /home/iojs/workspace

USER iojs:iojs

CMD /usr/local/bin/lint-node.sh
