#!/bin/bash
set -o monitor

/docker-entrypoint.sh "$@" &

# Wait some seconds to check the service is running
for i in {5..0}; do
    if rabbitmqctl status; then
        break
    fi
    echo 'RabbitMQ init process in progress...'
    sleep 1
done
if [ "$i" = 0 ]; then
    echo >&2 'RabbitMQ init process failed.'
    exit 1
fi

# Once the process is available it needs some time to accept commands, the admin user needs to exist.
sleep 5

echo
    for f in /docker-entrypoint-initrabbitmq.d/*; do
        case "$f" in
            *.sh)     echo "$0: running $f"; . "$f" ;;
            *)        echo "$0: ignoring $f" ;;
        esac
        echo
    done

jobs

fg %1
