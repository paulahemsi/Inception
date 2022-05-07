FROM		debian:buster

RUN			apt-get update && apt-get install mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/* \
&& mkdir -p /var/run/mysqld \
&& chown -R mysql:mysql /var/run/mysqld \
&& chmod 777 /var/run/mysqld

COPY		./tools/mariadb.sh /usr/local/bin/
COPY		./conf/wordpress.sql /usr/local/bin/

EXPOSE		3306

ENTRYPOINT	["mariadb.sh"]

CMD			["mysqld", "--bind-address=0.0.0.0"]
