#!/bin/sh

DATABASE_PATH=/var/lib/mysql/$MYSQL_DATABASE

if [ ! -d "$DATABASE_PATH" ]
then
	mkdir -p /var/run/mysqld;
	chown -R mysql:mysql /var/run/mysqld;
	chmod 777 /var/run/mysqld;

	service mysql start;
	mysql -u root --execute="CREATE DATABASE $MYSQL_DATABASE; \
				 CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD'; \
				 ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
				 GRANT ALL PRIVILAGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost';";	
	service mysql stop;
fi

exec "$@"
