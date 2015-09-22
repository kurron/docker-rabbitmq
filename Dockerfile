# Official RabbitMQ Image 
FROM rabbitmq:management 

MAINTAINER Ron Kurr <kurr@kurron.org>

# copy in the custom configurations
ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config
ADD rabbitmq-server etc/default/rabbitmq-server 

