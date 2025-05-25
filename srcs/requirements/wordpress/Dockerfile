FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	php-fpm \
	php-mysql \
	php-zip \
	curl &&\
	sed -i 's/listen =.*/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

RUN mkdir -p /run/php

WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN wp core download --allow-root

COPY ./script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["bash", "script.sh"]