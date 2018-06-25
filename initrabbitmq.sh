#!/bin/bash
set -o monitor

: ${RABBIT_SLEEP_SECONDS:=5}

rabbit_pid=/var/lib/rabbitmq/mnesia/rabbitmq.pid
RABBITMQ_PID_FILE=$rabbit_pid exec /docker-entrypoint.sh "$@" &

sleep ${RABBIT_SLEEP_SECONDS}

rabbitmqctl wait $rabbit_pid

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
