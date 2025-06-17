FROM alpine:3.20

RUN apk update && apk add mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./config/initdb.sh /initdb.sh
COPY ./config/mariadb.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod +x /initdb.sh

EXPOSE 3306

ENTRYPOINT ["/initdb.sh"]
