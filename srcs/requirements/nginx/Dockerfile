FROM debian:buster

WORKDIR /

RUN apt update; \
	apt-get install -y \
	apt-utils \
	nginx \
	openssl \
	procps \
	nano

COPY conf/ /srcs/
COPY ./tools/nginx.sh /usr/local/bin/

RUN openssl req -new -nodes -x509 \
	-newkey rsa:4096 \
	-sha256 \
	-days 365 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42 School/OU=phemsi-a/CN=phemsi-a.42.com"

EXPOSE 443

ENTRYPOINT ["nginx.sh"]
CMD ["nginx", "-g", "daemon off;"]
