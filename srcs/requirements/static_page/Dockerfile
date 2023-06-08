FROM debian:buster

RUN apt-get update -y

RUN apt install -y nginx

COPY ./conf/portoflio /var/www/html/portoflio

COPY /conf/default /etc/nginx/sites-available/default

ENTRYPOINT ["nginx", "-g", "daemon off;"]
