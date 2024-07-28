FROM rockylinux:9

ENV DB_HOST=192.168.1.3 \
    DB_USER=admin \
    DB_PASS=passwd \
    DB_NAME=wordpress

COPY ./web /web

COPY ./init/installation.sh /usr/local/bin/installation.sh

EXPOSE 80 443

RUN chmod +x /usr/local/bin/installation.sh
RUN /usr/local/bin/installation.sh
RUN tar zxvf /var/www/wordpress-6.6.1.tar.gz -C /var/www/
RUN chown -R apache. /var/www/wordpress
RUN chmod -R 600 /etc/ssl/certs/server.key
RUN chmod -R 600 /etc/pki/tls/certs/server.key
RUN chmod -R 755 /var/www/wordpress

CMD [ "httpd", "-D", "FOREGROUND" ]
    