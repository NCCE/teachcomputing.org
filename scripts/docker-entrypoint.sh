#!/bin/sh

set -e

HOST=0.0.0.0
PORT=3000
DEBUG_PORT=1234
DISPATCHER_PORT=26162

PID="tmp/pids/server.pid"
if [ -f $PID ]; then
  rm $PID
fi

echo "-Installing the bundle (this may take a little while if the volume is empty):"
bundle config set force_ruby_platform true
bundle install

echo "- Configuring databases:"
bundle exec rake db:prepare

echo "- Installing node packages with yarn:"
yarn install

echo "- Starting rails (with debugging enabled):"
(trap 'kill 0' SIGINT;
  rdebug-ide --skip_wait_for_start -h $HOST -p $DEBUG_PORT --dispatcher-port $DISPATCHER_PORT -- ./bin/rails s -b $HOST -p $PORT &
  bundle exec sidekiq > ./log/sidekiq.log &
  ./scripts/webpack-docker-entrypoint.sh > ./log/webpack.log
)
# ./bin/rails s -b $HOST -p $PORT
