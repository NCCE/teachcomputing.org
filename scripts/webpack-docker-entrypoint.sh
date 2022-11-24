#!/bin/sh

set -e

echo "- Installing node packages with yarn:"
yarn install

echo "- Starting webpack dev server:"
./bin/webpack-dev-server
