FROM debian:10


RUN apt update -y 

RUN apt install php-fpm php-mysql -y

RUN apt install curl -y


COPY ./script.sh /
RUN chmod +x script.sh
COPY ./wp-config.php /


CMD [ "/script.sh" ]