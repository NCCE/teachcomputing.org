#!/bin/bash
source ./scripts/yaml-parser.sh
create_variables ./nginx-mapping.yml 'nginx_'
URL="http://${nginx_mappings__prefix[0]}.${nginx_domain_root}"
URL_TO_POLL="http://localhost:${nginx_mappings__port[0]}"
TIMEOUT=75
OK_TO_PROCEED=0

# Create a tunnel
# I've a created a host under ~/.ssh/config called 'proxy', but you can use -i to specify your own key
printf %s "- Setting up the tunnel: "
COMMAND="$(nc -z localhost 8889 2>&1)"
if [[ $COMMAND =~ .*succeeded.* ]]; then
  echo "already exists"
else
  yarn run start-tunnel
  echo "done"
fi

# Brings the stack up and polls for availability
echo "- Bringing up the stack:"
docker compose up -d
printf %s "- trying for ${TIMEOUT}s (ctrl+c to cancel): "
SECONDS=0
while (( SECONDS < TIMEOUT )); do
  if ! curl -sSf "$URL_TO_POLL" &> /dev/null; then
    sleep 1;
  else
    OK_TO_PROCEED=1
    break
  fi
done

if [ $OK_TO_PROCEED = 1 ]; then
  echo "done"
  # Conditionally open a browser window
  printf %s "- Open ${URL} in your default browser (y/n)? "
  read -r RESP
  if [ "$RESP" != "${RESP#[Yy]}" ]; then
    echo "- Opening page, if the page fails to load ensure you've run 'yarn run setup' and 'sudo dev-nginx restart'"
    open "$URL"
  fi
else
  echo "failed"
  echo "- Check the logs:"
  docker compose logs --tail 50
fi
