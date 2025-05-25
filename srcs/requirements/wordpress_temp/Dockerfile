FROM debian:bullseye

RUN apt-get update && apt-get install -y php7.4-fpm php7.4-mysql mariadb-client curl && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/php \
    && chown www-data:www-data /run/php \
    && chmod 755 /run/php

COPY tools/entrypoint.sh /usr/local/bin/
COPY conf/wp-config.php /usr/local/bin/wp-config.php
COPY conf/php-fpm.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]
