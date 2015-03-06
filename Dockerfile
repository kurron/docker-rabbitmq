# Trusty 
FROM ubuntu:14.04

MAINTAINER Ron Kurr <kurr@kurron.org>

# fetch the latest software updates
RUN apt-get --quiet update && \
    apt-get --quiet --yes install wget && \
    wget --quiet --output-document=/tmp/rabbitmq-signing-key-public.asc http://www.rabbitmq.com/rabbitmq-signing-key-public.asc && \
    apt-key add /tmp/rabbitmq-signing-key-public.asc && \
    echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list && \
    apt-get --quiet update && \
    apt-get --quiet --yes install rabbitmq-server && \
    apt-get clean && \
    /usr/sbin/rabbitmq-server -detached  && \ 
    rabbitmq-plugins enable rabbitmq_management && \
    rabbitmq-plugins enable rabbitmq_consistent_hash_exchange && \
    rabbitmq-plugins enable rabbitmq_federation && \
    rabbitmq-plugins enable rabbitmq_shovel && \
    rabbitmq-plugins enable rabbitmq_stomp && \
    rabbitmq-plugins enable rabbitmq_tracing && \
    rabbitmq-plugins enable rabbitmq_mqtt && \
    rabbitmq-plugins enable rabbitmq_web_stomp && \
    rabbitmq-plugins list && \
    echo '[{rabbit, [{loopback_users, []}]}].' > /etc/rabbitmq/rabbitmq.config

# Define environment variables so we can use external file system for persistence.
ENV RABBITMQ_LOG_BASE /data/log
ENV RABBITMQ_MNESIA_BASE /data/mnesia

# export meta-data about this container
ENV KURRON_RABBITMQ_VERSION Unknown

# Define mount points.
VOLUME ["/data/log", "/data/mnesia"]

# Define working directory.
WORKDIR /data

# expose both the amqp and admin ports 
EXPOSE 5672 15672

# run RabbitMQ each time the container is started 
ENTRYPOINT ["/usr/sbin/rabbitmq-server"]

