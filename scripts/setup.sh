#!/bin/bash
source ./scripts/yaml-parser.sh
create_variables ./nginx-mapping.yml 'y_'
URL="${y_mappings__prefix[0]}.${y_domain_root}"

printf %s "- Copy .env-example? WARNING this will overwrite any existing environment variables (y/n)? "
read RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  cp .env-example .env
fi

echo "- Building the image"
docker-compose build

echo "- Install dev-nginx"
brew tap guardian/homebrew-devtools
brew install guardian/devtools/dev-nginx

echo "- Setup mapping"
dev-nginx setup-app nginx-mapping.yml
dev-nginx add-to-hosts-file $URL
