# basi/rabbitmq

It extends the official Docker RabitMQ image and adds the possibility of execute shell scripts when launching a container.

It's useful to initialize vhosts, permissions, etc.

For test the automatic registration of the vhosts and other configurations just execute the sample:

docker run --rm --name rabbit-test basi/rabbitmq:latest
