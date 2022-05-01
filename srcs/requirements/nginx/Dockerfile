FROM		debian:buster

RUN			apt-get update && apt-get install -y wget apt-utils
RUN			apt-get install -y nginx
RUN			apt-get install -y procps

EXPOSE		443

ENTRYPOINT	["nginx"]
CMD	["-g", "daemon off;"]
