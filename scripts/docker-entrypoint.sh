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

echo "- Configuring databases:"
if bundle exec rake db:exists; then
  bundle exec rake db:migrate
else
  bundle exec rake db:setup
fi

echo "- Starting rails:"
# Will start normally, allowing later debug sessions
rdebug-ide --skip_wait_for_start --host $IP --port $DEBUG_PORT -- $RAILS_EXECUTABLE s -p $PORT -b $IP
