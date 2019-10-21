#!/bin/bash

## Intended to be executed from Jenkins, `curl https://.../execute.sh | bash -`.
##
## Should be executed in git clone of the nodejs/node repository. The command
## `shyaml` should be available (from python3-pip). The repository should have
## a .ci.yml file and $CONTAINER_TESTS should be set to a named test section
## in that YAML file. That section should contain an "image" property that will
## be appended to 'rvagg/node-ci-containers:' to find the Docker Hub image,
## and an "execute" property that contains the script to run to execute the
## build & test.

set -x
set -e

echo "Running ${CONTAINER_TESTS} ..."

image_name=$(cat .ci.yml | shyaml get-value "${CONTAINER_TESTS}.image")
execute_cmds=$(cat .ci.yml | shyaml get-value ${CONTAINER_TESTS}.execute)

if ! [[ "$image_name" =~ ^[a-zA-Z0-9/_-]+$ ]]; then
  echo "Bad image name: ${image_name}"
  exit 1
fi

ccache_dir=/home/iojs/.ccache/${image_name}
echo "Using ccache directory: ${ccache_dir}"
mkdir -p $ccache_dir

# env.properties has some variables we want to make available in the build
execute_cmds=". ./env.properties; ${execute_cmds}"
echo "${execute_cmds}" > node-ci-exec.sh

sudo /usr/local/bin/docker-node-exec.sh -i $image_name
