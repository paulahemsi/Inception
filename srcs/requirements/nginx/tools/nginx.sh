#!/bin/sh

SERVER_CONF=/etc/nginx/sites-available/phemsi-a

if [ ! -f "$SERVER_CONF" ]
then
	mkdir /var/www/phemsi-a
	mv /srcs/phemsi-a /etc/nginx/sites-available/
	sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/sites-available/phemsi-a
	ln -s /etc/nginx/sites-available/phemsi-a etc/nginx/sites-enabled/
	mv /srcs/self-signed.conf /etc/nginx/snippets/
	mv /srcs/ssl-params.conf /etc/nginx/snippets/
fi

exec "$@"