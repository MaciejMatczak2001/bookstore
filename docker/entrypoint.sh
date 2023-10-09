#!/bin/bash

SEED_CONTROL_FILE=/app/tmp/seeds.setup

echo "Running bundle"
bundle --jobs `expr $(cat /proc/cpuinfo | grep -c 'cpu cores')` --retry 3

if [ -f "$SEED_CONTROL_FILE" ]; then
  echo "DB already set up"
else
  echo 'Setting up the DB'

  # bundle exec rails db:drop db:create db:schema:load db:seed --trace

  if [[ $? == 0 ]]; then
    touch $SEED_CONTROL_FILE
  else
    echo
    echo "Failed to run DB setup"
    exit 1
  fi
fi

echo "Running DB migrations"
# bundle exec rake db:migrate
if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate."
  exit 1
fi

# Execute the given or default command:
exec "$@"

