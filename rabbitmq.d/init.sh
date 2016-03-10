#!/bin/bash
echo "Creating users & Vhost"
rabbitmqctl add_user god shuwaef8X \
    && rabbitmqctl add_vhost god \
    && rabbitmqctl set_permissions -p god god ".*" ".*" ".*"
