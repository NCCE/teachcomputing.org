#!/bin/sh
set -e

HOST=0.0.0.0
PORT=3000
# DEBUG_PORT=1234
# DISPATCHER_PORT=26162

PID="tmp/pids/server.pid"
if [ -f $PID ]; then
  rm $PID
fi

echo "- Configuring databases:"
bundle exec rake db:prepare

echo "- Starting rails:"
# rdebug-ide --skip_wait_for_start -h $HOST -p $DEBUG_PORT --dispatcher-port $DISPATCHER_PORT -- ./bin/rails s -b $HOST -p $PORT
./bin/rails s -b $HOST -p $PORT
