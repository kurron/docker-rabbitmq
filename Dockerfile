# Official RabbitMQ Image 
FROM rabbitmq:management 

MAINTAINER Ron Kurr <kurr@kurron.org>

RUN ["/bin/rm", "-f", "/etc/rabbitmq/rabbitmq.config"]
ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config

ADD rabbitmq-server /etc/default/rabbitmq-server 

