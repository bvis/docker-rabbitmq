FROM rabbitmq:3.6-management

RUN mkdir /docker-entrypoint-initrabbitmq.d

COPY initrabbitmq.sh /

ENTRYPOINT ["/initrabbitmq.sh"]

CMD ["rabbitmq-server"]

