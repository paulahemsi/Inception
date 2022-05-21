#!/bin/sh

DATABASE_PATH=/var/lib/mysql/$MYSQL_DATABASE

if [ ! -d "$DATABASE_PATH" ]
then
	service mysql start;
	mysql -u root --execute="CREATE DATABASE $MYSQL_DATABASE; \
				 CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
				 ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
				 GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';";	
	service mysql stop;
	
fi

exec "$@"
