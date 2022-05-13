FROM		debian:buster

RUN			apt-get update && apt-get -y install \
			wget \
			apt-utils \
			nano \
			nginx \
			procps
RUN			openssl req -new -nodes -x509 \
			-newkey rsa:4096 \
			-sha256 \
			-days 365 \
			-keyout /etc/ssl/private/nginx-selfsigned.key \
			-out /etc/ssl/certs/nginx-selfsigned.crt \
			-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42 School/OU=phemsi-a/CN=phemsi-a.42.fr"

COPY		./conf/ /srcs/

RUN			mkdir /var/www/phemsi-a && \
			mv /srcs/nginx.conf /etc/nginx/sites-available/ && \
			ln -s /etc/nginx/sites-available/nginx.conf etc/nginx/sites-enabled/ && \
			mv /srcs/self-signed.conf /etc/nginx/snippets/ && \
			mv /srcs/ssl-params.conf /etc/nginx/snippets/ 
			# mv /srcs/index.html /var/www/phemsi-a/ && \
			# mv /srcs/index.php /var/www/phemsi-a/

EXPOSE		443

ENTRYPOINT	["nginx"]
CMD			["-g", "daemon off;"]
