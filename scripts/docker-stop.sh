#!/bin/bash
echo "- Bringing the stack down"
docker-compose down
echo "- Removing the tunnel"
ps aux | grep ssh | grep "8889" | awk "{print \$2}" | xargs kill
