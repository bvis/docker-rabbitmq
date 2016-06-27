FROM rabbitmq:3.6-management

RUN mkdir /docker-entrypoint-initrabbitmq.d

COPY initrabbitmq.sh /

ENTRYPOINT ["/initrabbitmq.sh"]

CMD ["rabbitmq-server"]

# Auto-health check to the root page
HEALTHCHECK --interval=10s --timeout=5s \
  CMD rabbitmqctl status || exit 1
