#!/bin/sh

set -e

echo "- Building CSS:"
yarn build:css

echo "- Watching CSS for changes:"
yarn build:css:sass --watch &
yarn build:css:postcss --watch
