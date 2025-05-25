FROM debian:10

RUN apt -y update
RUN apt install -y nginx
RUN apt install -y openssl

COPY ./createConf.sh .
RUN chmod +x createConf.sh
RUN bash -x createConf.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]