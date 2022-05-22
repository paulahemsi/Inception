#!/bin/sh

SERVER_CONF=/etc/nginx/sites-available/phemsi-a

if [ ! -f "$SERVER_CONF" ]
then
	# SSL cert
	openssl req -new -nodes -x509 \
	-newkey rsa:4096 \
	-sha256 \
	-days 365 \
	-keyout $CERT_KEY_ \
	-out $CERTS_ \
	-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42 School/OU=phemsi-a/CN=phemsi-a.42.com"
	# domain configs
	mkdir -p /var/www/phemsi-a
	mv /srcs/phemsi-a /etc/nginx/sites-available/
	sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/sites-available/phemsi-a 
	sed -i -r "s#CERTS_#$CERTS_#g" /etc/nginx/sites-available/phemsi-a 
	sed -i -r "s#CERT_KEY_#$CERT_KEY_#g" /etc/nginx/sites-available/phemsi-a 
	ln -s /etc/nginx/sites-available/phemsi-a etc/nginx/sites-enabled/
	mv /srcs/ssl-params.conf /etc/nginx/snippets/
fi

exec "$@"