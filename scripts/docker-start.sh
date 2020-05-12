#!/bin/sh

URL=http://localhost:3000

# Create a tunnel
# I've a created a host under ~/.ssh/config called 'proxy', but you can use -i to specify your own key
printf %s "- Setting up the tunnel: "
COMMAND="$(nc -z localhost 8889 2>&1)"
if [[ $COMMAND =~ .*succeeded.* ]]; then
  echo "already exists"
else
  ssh -f -C -N -D 8889 -L8888:127.0.0.1:8888 proxy
  echo "done"
fi

# Brings the stack up and polls for availability
echo "- Bringing up the stack:"
docker-compose up -d
printf %s "- Waiting for the stack to become available (Ctrl+C to cancel): "
while ! curl -sSf $URL &> /dev/null ; do sleep 1; done
echo "done"

# Check the status of the stack
echo "- Checking the stack:"
docker-compose ps

# Conditionally open a browser window
printf %s "- Open localhost:3000 in your default browser (y/n)? "
read RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  echo "- Opening page" # Should probably use your default browser :)
  open $URL
fi
