#!/bin/bash
source ./scripts/yaml-parser.sh
create_variables ./nginx-mapping.yml 'nginx_'
CONFIG_FILE="/usr/local/etc/nginx/servers/${nginx_name}.conf"

echo "- Setting up homebrew"
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }

echo "- Setting up npm"
brew install node@12
npm i

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
if [ -f $CONFIG_FILE ] && ! grep -q 'X-Forwarded-Ssl' $CONFIG_FILE
then
  sed -i '' '/proxy_buffering off\;/a\
  proxy_set_header  X-Forwarded-Ssl on\;' $CONFIG_FILE
  dev-nginx restart-nginx
fi
