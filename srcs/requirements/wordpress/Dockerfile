FROM debian:buster

RUN apt-get update && apt-get -y install \
wget \
apt-utils \
nano \
procps \
php \
php-cgi \
php-mysql \
# Nginx requires to handle PHP processing
php-fpm \ 
php-pdo \
php-gd php-cli \
php-mbstring

RUN mkdir /var/www && mkdir /var/www/phemsi-a

# php config
# COPY ./conf/wp-config.php /
# COPY conf/php-fpm.conf /etc/php7/php-fpm.conf
# COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/
RUN mkdir /run/php

COPY ./tools/wordpress.sh /usr/local/bin/

WORKDIR /var/www/phemsi-a/

ENTRYPOINT ["wordpress.sh"]

EXPOSE 9000

#Force to stay in foreground and ignore daemonize option from configuration file
CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]
