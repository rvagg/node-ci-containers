#!/bin/bash -xe

which node && ln -s -f $(which node)
node --version

PYTHON=python2

make lint-md-build PYTHON=$PYTHON || true
make lint-py-build PYTHON=$PYTHON || true

NODEJS_MAJOR_VERSION=$($PYTHON tools/getnodeversion.py | cut -d. -f1)

# Lint with python3 in new branches
# Refs: https://github.com/nodejs/build/issues/1631
if [[ "$NODEJS_MAJOR_VERSION" -ge "12" ]]
then
	make lint-py PYTHON=python3
fi
    
# If lint-ci fails, print all the interesting lines to the console.
# FreeBSD sed can't handle \s, so use gsed if it exists.
make lint-ci PYTHON=$PYTHON || { 
  cat test-eslint.tap | grep -v '^ok\|^TAP version 13\|^1\.\.' | sed '/^\s*$/d' && 
  exit 1; }
