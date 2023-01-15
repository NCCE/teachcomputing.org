#!/bin/bash
source ./scripts/yaml-parser.sh
create_variables ./nginx-mapping.yml 'nginx_'

echo "- Setting up homebrew"
if command -v brew >/dev/null 2>&1; then
  echo '...skipping as already installed'
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  source ~/.zprofile
fi

echo "- Setting up yarn"
if command -v yarn >/dev/null 2>&1; then
  echo '...skipping as already installed'
else
  brew install yarn
  yarn install
fi

printf %s "- Create a new .env file from the defaults - WARNING this will overwrite any existing environment variables (y/n)? "
read -r RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  cp .env.defaults .env
fi

printf %s "- Build the docker image (y/n)? "
read -r RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  docker compose build --no-cache
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

if command -v heroku &> /dev/null; then
  echo '...skipping heroku cli as already installed'
else
  echo "- Setup heroku cli https://devcenter.heroku.com/articles/heroku-cli"
  brew tap heroku/brew && brew install heroku
fi
