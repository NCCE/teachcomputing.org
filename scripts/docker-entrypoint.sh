#!/bin/sh

set -e

PID="tmp/pids/server.pid"
if [ -f $PID ]; then
  rm $PID
fi

echo "- Configuring databases:"
rake db:exists && rake db:migrate || rake db:setup

echo "- Starting rails:"
# bundle exec rdebug-ide --host 0.0.0.0 --port 1234 rails s -b 0.0.0.0 -p 3000
rails s -b 0.0.0.0 -p 3000
