#!/bin/bash
echo "- Bringing the stack down"
docker-compose down
echo "- Removing the tunnel"
yarn run stop-tunnel
