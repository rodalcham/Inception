FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install -y mariadb-server procps

COPY ./startMDB.sh .
RUN chmod +x startMDB.sh

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 
# RUN bash ./startMDB.sh

# RUN groupadd -r mysql && useradd -r -g mysql mysql

# USER mysql  # Run the container as the mysql user

ENTRYPOINT ["bash", "./startMDB.sh"]

CMD ["mysqld_safe"]
# CMD ["bash", "./startMDB.sh"]