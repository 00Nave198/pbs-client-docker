#!/bin/bash

# Cron will read the env from here
env >> /etc/environment

if [ -x /usr/local/bin/custom.sh ]; then
    # Run some custom, user mounted code
    /usr/local/bin/custom.sh
fi

# Enable provided cronfiles 
if [ ! -z ${CRON_LIST+x} ]; then
    IFS=', ' read -r -a CRON_ARRAY <<< "${CRON_LIST}"
    for element in "${CRON_ARRAY[@]}"
    do 
        if [ -f "${element}" ]; then
            echo "Found cronfile at ${element}"
            chmod 644 "${element}"
            crontab "${element}"
        elif [ -f "/etc/cron.d/${element}" ]; then
            echo "Found cronfile ${element} in /etc/cron.d/"
            chmod 644 "/etc/cron.d/${element}"
            crontab "/etc/cron.d/${element}"
        fi
    done
fi

# Display and execute command
echo "$@"
exec "$@"