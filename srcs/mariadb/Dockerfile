FROM debian:10

RUN apt-get update -y
RUN apt-get install mariadb-server -y

COPY ./startMDB.sh .
RUN chmod +x startMDB.sh

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 
# RUN bash ./startMDB.sh

ENTRYPOINT ["./startMDB.sh"]