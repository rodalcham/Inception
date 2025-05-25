FROM debian:bullseye


RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	php-fpm \
	php-mysql \
	php-mbstring \
	wget \
	ca-certificates \
	curl \
	less \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY ./script.sh /
RUN chmod +x /script.sh

EXPOSE 9000

CMD [ "/script.sh" ]