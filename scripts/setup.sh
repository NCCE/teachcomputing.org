#!/bin/bash
printf %s "- Copy .env-example? WARNING this will overwrite any existing environment variables (y/n)? "
read RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  cp .env-example .env
fi

printf %s "- Build the docker image (y/n)? "
read RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  docker-compose build
fi

echo "- Install dev-nginx"
brew tap guardian/homebrew-devtools
brew install guardian/devtools/dev-nginx

echo "- Setup mapping"
dev-nginx setup-app nginx-mapping.yml
