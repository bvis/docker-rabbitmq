# basi/rabbitmq

It extends the official Docker RabitMQ image and adds the possibility of execute shell scripts when launching a container.

It's useful to initialize vhosts, permissions, etc.

For test the automatic registration of the vhosts and other configurations, assuming you have ".sh" scripts in the _./setup_ directory:

```
$ cat setup/notifications_bus.sh
#!/bin/bash
rabbitmqctl add_user MYUSER MYPASS \
    && rabbitmqctl add_vhost MYVHOST \
    && rabbitmqctl set_permissions -p MYVHOST MYUSER ".*" ".*" ".*"
```
It creates a new vhost named "MYVHOST" and a user named "MYUSER" that will have all the permissions on the vhost.

It will we executed once the rabbit service is running:
```
$ docker run --rm --name rabbit-test -v $PWD/setup:/docker-entrypoint-initrabbitmq.d/ basi/rabbitmq:latest
```

It provides a self healthcheck system.
