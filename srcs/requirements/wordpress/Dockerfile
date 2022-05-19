FROM debian:buster

RUN apt-get update && apt-get -y install \
	wget \
	apt-utils \
	nano \
	procps \
	php7.3 \
	# Nginx requires to handle PHP processing
	php7.3-fpm \
	php7.3-opcache \
	php7.3-cli \
	php7.3-gd \
	php7.3-curl \
	php7.3-mysql \
	php7.3-mbstring

RUN mkdir /run/php && \
	mkdir -p /var/www/phemsi-a && \
	wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && \
	rm latest.tar.gz && \
	mv wordpress /var/www/phemsi-a/wordpress

COPY conf/ /srcs/
COPY tools/ /usr/local/bin/

RUN cp /srcs/www.conf /etc/php/7.3/fpm/pool.d/

WORKDIR /var/www/phemsi-a/

ENTRYPOINT ["wordpress.sh"]

EXPOSE 9000

#Force to stay in foreground and ignore daemonize option from configuration file
CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]
