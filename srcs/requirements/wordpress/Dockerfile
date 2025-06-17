FROM alpine:3.22

RUN apk update && apk add \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-curl \
    php83-dom \
    php83-mbstring \
    php83-openssl \
    php83-xml \
    php83-phar \
    php83-session \
    mariadb-client \
    wget \
    bash

RUN mkdir -p /var/www/html
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY conf/wp-entry.sh /usr/local/bin/wp-entry.sh
COPY conf/php.ini /etc/php83/php.ini

RUN chmod +x /usr/local/bin/wp-entry.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-entry.sh"]
CMD ["/usr/sbin/php-fpm83", "-F"]
