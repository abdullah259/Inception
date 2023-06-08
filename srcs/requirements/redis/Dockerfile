FROM debian:buster

RUN		apt-get update
RUN		apt-get install -y redis
RUN sed -i '/^bind/c\#' /etc/redis/redis.conf
RUN sed -i '/^protected-mode yes/c\protected-mode no' /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf", "--daemonize no"]
