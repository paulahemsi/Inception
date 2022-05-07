FROM debian:buster

RUN apt-get update && apt-get -y install \
wget \
apt-utils \
php \
php-cgi \
php-mysql \
# Nginx requires to handle PHP processing
php-fpm \ 
php-pdo \
php-gd php-cli \
php-mbstring

RUN mkdir /var/www && mkdir /var/www/phemsi-a

COPY ./conf/www.conf /var/www/phemsi-a/
RUN mkdir /run/php

COPY ./tools/wordpress.sh /usr/local/bin/

WORKDIR /var/www/phemsi-a/

ENTRYPOINT ["wordpress.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
