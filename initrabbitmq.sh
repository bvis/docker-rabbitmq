#!/bin/bash
set -o monitor

/docker-entrypoint.sh "$@" &

# Wait some seconds to check the service is running
for i in {30..0}; do
    if rabbitmqctl list_users; then
        break
    fi
    echo 'RabbitMQ init process in progress...'
    sleep 1
done
if [ "$i" = 0 ]; then
    echo >&2 'RabbitMQ init process failed.'
    exit 1
fi

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
