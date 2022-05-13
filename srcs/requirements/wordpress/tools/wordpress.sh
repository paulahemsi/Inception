#!/bin/sh

WP_CONFIG=/var/www/phemsi-a/wordpress/wp-config.php

if [ ! -f "$WP_CONFIG" ]
then
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm latest.tar.gz
	
	rm -rf /etc/php/7.3/fpm/pool.d/www.conf
	mv ./www.conf /etc/php/7.3/fpm/pool.d/
	
	cd /var/www/phemsi-a/wordpress
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	mv wp-config-sample.php wp-config.php
fi

exec "$@"
