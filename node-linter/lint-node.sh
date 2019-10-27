#!/bin/bash -ex

NODEJS_MAJOR_VERSION=$(python tools/getnodeversion.py | cut -d. -f1)

# Lint with python3 in new branches
# Refs: https://github.com/nodejs/build/issues/1631
if [[ "$NODEJS_MAJOR_VERSION" -ge "12" ]]; then
  make lint-py-build PYTHON=python3 || true
  make lint-py PYTHON=python3
fi

make lint-py-build PYTHON=python2 || true
make lint-ci PYTHON=python2 || {
  cat test-eslint.tap | grep -v '^ok\|^TAP version 13\|^1\.\.' | sed '/^\s*$/d' &&
  exit 1; }
