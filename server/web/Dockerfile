FROM rockylinux:9

ENV DB_HOST = 192.168.1.3 \
    DB_USER = admin \
    DB_PASS = passwd \
    DB_NAME = wordpress

COPY ./web /web

COPY ./init/installation.sh /usr/local/bin/installation.sh

EXPOSE 80 443

RUN chmod +x /usr/local/bin/installation.sh

RUN /usr/local/bin/installation.sh

CMD [ "httpd", "-D", "FOREGROUND" ]
    