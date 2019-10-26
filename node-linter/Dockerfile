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

RUN mkdir -p /home/iojs/workspace && chown node.node -R /home/iojs/

VOLUME /home/iojs/workspace

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  USER=node \
  JOBS=2 \
  SHELL=/bin/bash \
  HOME=/home/iojs

WORKDIR /home/iojs/workspace

USER node:node

CMD /usr/local/bin/lint-node.sh
