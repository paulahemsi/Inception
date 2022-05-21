FROM		debian:buster

RUN			apt-get update && apt-get install -y \
			apt-utils \
			mariadb-server \
			procps \
			nano \
			# ! To keep pid and socket for signals and comunication
			&& mkdir -p /var/run/mysqld \
			&& chown -R mysql:mysql /var/run/mysqld

COPY		./tools/mariadb.sh /usr/local/bin/
#COPY		./conf/wordpress.sql /usr/local/bin/

EXPOSE		3306

ENTRYPOINT ["mariadb.sh"]

CMD			["mysqld", "--bind-address=0.0.0.0"]
