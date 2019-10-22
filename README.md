# node-ci-containers

**A set of container images used in the Node.js CI system to run tests against changes as they are introduced.**

Available on Docker Hub @ https://hub.docker.com/r/rvagg/node-ci-containers

## What is this?

Each container sets up a minimal build environment required to test a particular build configuration. Some are generic, such as `ubuntu1804`, for use in general-purpose testing that doesn't require a special environment. Some are to test a specific distribution, such as the `fedora*` images. Some are specific to a distribution configuration, such as `centos7-devtoolset7`. And some contain specific software or configuration to test a particular build mode, such as `ubuntu1804_zlib` which tests Node.js compiled against a shared zlib.

## Images

* [`rvagg/node-ci-containers:alpine310`](https://github.com/rvagg/node-ci-containers/blob/master/alpine310) - Alpine 3.10 with basic build tools
* [`rvagg/node-ci-containers:centos7-devtoolset7`](https://github.com/rvagg/node-ci-containers/blob/master/centos7-devtoolset7) - CentOS 7 with Devtoolset-7 installed and configured
* [`rvagg/node-ci-containers:debian9`](https://github.com/rvagg/node-ci-containers/blob/master/debian9) - Debian 9 (Stretch) with basic build tools
* [`rvagg/node-ci-containers:fedora30`](https://github.com/rvagg/node-ci-containers/blob/master/fedora30) - Fedora 30 with basic build tools
* [`rvagg/node-ci-containers:ubuntu1804`](https://github.com/rvagg/node-ci-containers/blob/master/ubuntu1804) - Ubuntu 18.04 (Bionic) LTS with basic buils tools and some extras, intended to be the generic workhorse where a test doesn't require a particular distribution or additional tools
* [`rvagg/node-ci-containers:ubuntu1804_openssl111`](https://github.com/rvagg/node-ci-containers/blob/master/ubuntu1804_openssl111) - Ubuntu 18.04 (Bionic) with basic build tools and OpenSSL 1.1.1 compiled and ready for shared-library linking in `$OPENSSL111DIR`.
* [`rvagg/node-ci-containers:ubuntu1804_zlib`](https://github.com/rvagg/node-ci-containers/blob/master/ubuntu1804_zlib) - Ubuntu 18.04 (Bionic) with basic build tools and zlib 1.2 compiled and ready for shared-library linking in `$ZLIB12DIR`.
* [`rvagg/node-ci-containers:ubuntu1910`](https://github.com/rvagg/node-ci-containers/blob/master/ubuntu1910) - Ubuntu 19.10 with basic build tools

## Adding more

New configurations should first attempt to use existing images where possible. Where a special environemnt is necessary a new image may be added. The container should:

* Only contain the necessary software and configuration necessary to run a build & test cycle and exclude the execution scripting.
* Should contain an `iojs` user and group, both `1000`.
* Should include `/home/iojs/.ccache` and `/home/iojs/workspace` volumes for mounting.
* Should include a verified working configuration of `ccache` (unless compiling is not intended for the container). This will most likely be through the use of `PATH` modification to redirect `gcc`, `g++`, and friends to `ccache` symlinks.

## Execution

These containers are executed by mapping the `image` property in the `.ci.yml` file in the root of the Node.js repository (https://github.com/nodejs/node/blob/master/.ci.yml). This property determines the image to pull down, and run.

The script in this repository, [execute.sh](https://github.com/rvagg/node-ci-containers/blob/master/execute.sh), performs the majority of the logic of the decoding `.ci.yml` and determining what to run and how to run it. This script is executed within [Jenkins](https://ci.nodejs.org) using `curl -sL https://raw.githubusercontent.com/rvagg/node-ci-containers/master/execute.sh | bash -` on a Docker host. Therefore this script should be edited with care!

Running the Docker container itself is delegated to `/usr/local/bin/docker-node-exec.sh` on the Docker host. This is to allow for restrictive access to privileged resources, as this script is the only resource the executing user may call with `sudo`. This script is [located in Node.js Build WG repository](https://github.com/nodejs/build/blob/master/ansible/roles/jenkins-worker/files/docker-node-exec.sh).

