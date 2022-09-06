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

echo "- Configuring databases:"
bundle exec rake db:prepare

echo "Installing node packinges with yarn"
yarn install

echo "-Updating the bundle (this may take a little if the volume is empty)"
bundle install

echo "- Starting rails (with debugging enabled):"
rdebug-ide --skip_wait_for_start -h $HOST -p $DEBUG_PORT --dispatcher-port $DISPATCHER_PORT -- ./bin/rails s -b $HOST -p $PORT
# ./bin/rails s -b $HOST -p $PORT
