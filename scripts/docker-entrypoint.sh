#!/bin/sh
set -e

RAILS_EXECUTABLE="bin/rails"
PORT=3000
IP=0.0.0.0
DEBUG_PORT=1234

PID="tmp/pids/server.pid"
if [ -f $PID ]; then
  rm $PID
fi

if [[ $ENV_TYPE == "development" ]]; then
  echo "- Configuring databases:"
  bundle exec rake db:exists && bundle exec rake db:migrate || bundle exec rake db:setup
fi

echo "- Starting rails:"
if [[ $ENV_TYPE == "development" ]]; then
  # Start in debug mode, to optionally debug with an ide
  rdebug-ide --skip_wait_for_start --host $IP --port $DEBUG_PORT -- $RAILS_EXECUTABLE s -p $PORT -b $IP
else
  $RAILS_EXECUTABLE s -b $IP -p $PORT
fi
