FROM debian:stable-slim

RUN apt-get update && apt-get install -y nginx php-fpm php-mysql

COPY nginx.conf /etc/nginx/nginx.conf

COPY wp-config.php /var/www/html/wp-config.php


EXPOSE 80

CMD service nginx start && service php7.4-fpm start && tail -f /dev/null



# COPY index.html /var/www/html/index.html

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]

