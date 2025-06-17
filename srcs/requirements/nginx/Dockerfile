FROM alpine:3.22

RUN apk update && apk add nginx openssl

COPY ./conf/gencert.sh /
RUN chmod u+x gencert.sh
RUN ./gencert.sh

COPY ./conf/nginxconf /etc/nginx/http.d/default.conf 

RUN mkdir -p /var/www/html
RUN chown -R nginx:nginx /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
