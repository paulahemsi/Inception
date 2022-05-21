FROM debian:buster

WORKDIR /

RUN apt update; \
	apt install -y \
	nginx \
	openssl \
	procps \
	nano

COPY conf/ /srcs/

RUN openssl req -new -nodes -x509 \
	-newkey rsa:4096 \
	-sha256 \
	-days 365 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42 School/OU=phemsi-a/CN=phemsi-a.42.com"

ENV DOMAIN_NAME "phemsi-a.42.fr" 

RUN mkdir /var/www/phemsi-a && \
	mv /srcs/phemsi-a /etc/nginx/sites-available/ && \
	sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/sites-available/phemsi-a && \
	ln -s /etc/nginx/sites-available/phemsi-a etc/nginx/sites-enabled/ && \
	mv /srcs/self-signed.conf /etc/nginx/snippets/ && \
	mv /srcs/ssl-params.conf /etc/nginx/snippets/ && \
	mv /srcs/index.php /var/www/phemsi-a/

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
