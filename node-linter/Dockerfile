FROM ubuntu:18.04

ENV LC_ALL=C DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install apt-utils -y && \
  apt-get dist-upgrade -y && \
  apt-get install -y \
    curl \
    apt-transport-https \
    apt-utils \
    dialog \
    make \
    python-pip \
    python3-pip

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get install nodejs && \
  npm install npm -g

RUN addgroup --gid 1000 iojs && \
  adduser --gid 1000 --uid 1000 --disabled-password --home /home/iojs --shell /bin/bash --gecos iojs iojs

COPY lint-node.sh /usr/local/bin/lint-node.sh

VOLUME /home/iojs/workspace

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  USER=iojs \
  JOBS=2 \
  SHELL=/bin/bash \
  HOME=/home/iojs

WORKDIR /home/iojs/workspace

USER iojs:iojs

CMD /usr/local/bin/lint-node.sh
