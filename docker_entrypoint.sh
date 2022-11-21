#!/bin/bash

# This script is used to start the container and run the application.

# Get the environment variables in order to setup the account
if [[ -z $SECRET_KEY || -z $USERNAME || -z $EMAIL || -z $DISPLAY_NAME || -z $PASSWORD ]]; then
  echo 'one or more variables are undefined'
  exit 1
fi

# Make DB folder
mkdir /data

# Initialise DB
/app/gpodder2go init -d /data/gpodder2go.db

# Start the application with no auth
export VERIFIER_SECRET_KEY=$SECRET_KEY
/app/gpodder2go serve -b 0.0.0.0:3005 -d /data/gpodder2go.db --no-auth &

# Create account from environment variables
/app/gpodder2go accounts create $USERNAME --email="$EMAIL" --name="$DISPLAY_NAME" --password="$PASSWORD"

# Kill existing process
kill $(ps aux | grep '[g]podder2go' | awk '{print $2}')

# Start the application with newly created user
/app/gpodder2go serve -b 0.0.0.0:3005 -d /data/gpodder2go.db

