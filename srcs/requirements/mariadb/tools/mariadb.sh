#!/bin/sh

DATABASE_PATH=/var/lib/mysql/$MYSQL_DATABASE

if [ ! -d "$DATABASE_PATH" ]
then
	echo "creating database";
	service mysql start;
	mysql -u root --execute="CREATE DATABASE $MYSQL_DATABASE; \
				 CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD'; \
				 ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
				 GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost';";
	echo "database created";
	service mysql stop;
	echo "mysql stoped";
fi

sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec "$@"
