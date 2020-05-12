#!/bin/sh
set -e

PID="tmp/pids/server.pid"
if [ -f $PID ]; then
  rm $PID
fi

echo "- Configuring databases:"
rake db:exists && rake db:migrate || rake db:setup

echo "- Starting rails:"
# if [ $ENV_TYPE == "development" ]; then
  # Start in debug mode, to optionally debug with an ide
  # rdebug-ide --host 0.0.0.0 --port 1234 -- bin/rails s -p 3000 -b 0.0.0.0
# else
  rails s -b 0.0.0.0 -p 3000
# fi
