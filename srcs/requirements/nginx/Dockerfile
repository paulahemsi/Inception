FROM debian:buster

WORKDIR /

RUN apt-get update; \
	apt-get install -y \
	apt-utils \
	nginx \
	openssl \
	procps \
	nano

COPY conf/ /srcs/
COPY ./tools/nginx.sh /usr/local/bin/

EXPOSE 443

ENTRYPOINT ["nginx.sh"]
CMD ["nginx", "-g", "daemon off;"]
