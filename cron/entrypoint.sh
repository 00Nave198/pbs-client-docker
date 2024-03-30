#!/bin/sh

# Cron will read the env from here
env >> /etc/environment

# Display and execute command
echo "$@"
exec "$@"