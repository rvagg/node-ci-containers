#!/bin/bash -xe

# If lint-ci fails, print all the interesting lines to the console.
make lint-ci || { 
  cat test-eslint.tap | grep -v '^ok\|^TAP version 13\|^1\.\.' | sed '/^\s*$/d' && 
  exit 1; }
