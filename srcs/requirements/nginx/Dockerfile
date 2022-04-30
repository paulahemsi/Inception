FROM		debian:buster

RUN			apt-get update && apt-get install -y wget apt-utils
RUN			apt-get install -y nginx

EXPOSE		443

ENTRYPOINT	service nginx start && sleep infinity
