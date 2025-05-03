FROM debian:10

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y php curl php-mysql

RUN mkdir -p /var/www/html /run/php
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /run/php

COPY www.conf /etc/php/7.4/fpm/pool.d/.

COPY script.sh .

RUN chmod +x script.sh

CMD ["./script.sh"]