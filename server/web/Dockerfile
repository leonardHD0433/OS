FROM rockylinux:9

ENV DB_HOST=192.168.1.3 \
    DB_USER=admin \
    DB_PASS=passwd \
    DB_NAME=wordpress

COPY ./web /web
COPY ./init/installation.sh /usr/local/bin/installation.sh
COPY ./init/copy_config.sh /usr/local/bin/copy_config.sh

EXPOSE 80 443

RUN chmod +x /usr/local/bin/installation.sh
RUN chmod +x /usr/local/bin/copy_config.sh
RUN /usr/local/bin/installation.sh
RUN /usr/local/bin/copy_config.sh
RUN chown -R apache. /var/www/wordpress &&  \
    chmod -R 600 /etc/ssl/certs/server.key && \
    chmod -R 600 /etc/pki/tls/certs/server.key && \
    chmod -R 755 /var/www/wordpress
RUN apachectl configtest

CMD [ "httpd", "-D", "FOREGROUND" ]
    