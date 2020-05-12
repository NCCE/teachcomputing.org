#!/bin/bash

# This is WIP, and a better approach to kill existing sessions might need to be found
RESTART_CONTAINERS=false
printf %s "Kill any open postgres sessions y/n? "
read RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  RESTART_CONTAINERS=true
fi
if $RESTART_CONTAINERS; then docker-compose stop db; fi
docker-compose run -e DISABLE_DATABASE_ENVIRONMENT_CHECK=1 --rm web bin/rails db:reset
if $RESTART_CONTAINERS; then docker-compose start db; fi
