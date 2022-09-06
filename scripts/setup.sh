#!/bin/bash
source ./scripts/yaml-parser.sh
create_variables ./nginx-mapping.yml 'nginx_'

echo "- Setting up homebrew"
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew now"; \
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }

echo "- Setting up yarn"
if command -v yarn >/dev/null 2>&1; then
  echo '...skipping as already installed'
else
  brew install yarn
  yarn install
fi

printf %s "- Copy .env-example? WARNING this will overwrite any existing environment variables (y/n)? "
read -r RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  cp .env-example .env
fi

printf %s "- Build the docker image (y/n)? "
read -r RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  docker compose build
fi

echo "- Install dev-nginx"

if command -v dev-nginx >/dev/null 2>&1; then
  echo '...skipping as already installed'
else
  brew tap guardian/homebrew-devtools
  brew install guardian/devtools/dev-nginx
  sudo ln -s /usr/local/opt/nginx/homebrew.mxcl.nginx.plist /Library/LaunchDaemons/
  sudo chown root:wheel /usr/local/opt/nginx/homebrew.mxcl.nginx.plist
  sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist
  brew upgrade dev-nginx
  brew services start nginx
fi

echo "- Install shared-mime-info for mimemagic"
brew install shared-mime-info

echo "- Setup mapping"
dev-nginx setup-app nginx-mapping.yml

printf %s "- Build assets (recommended for the first run, y/n)? "
read -r RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  yarn run exec rails assets:precompile
fi
