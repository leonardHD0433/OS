FROM rockylinux/rockylinux:9

RUN dnf install -y postfix && \
    dnf install -y dovecot && \
    dnf clean all

COPY ./cert/mail.crt ./cert/mail.key ./cert/mail.pem /etc/pki/tls/certs/

# Add the user with specific UID and shell
RUN useradd --uid 20000 --shell /sbin/nologin vmail

COPY ./conf/main.cf /etc/postfix/main.cf
COPY ./conf/master.cf /etc/postfix/master.cf
COPY ./conf/dovecot.conf /etc/dovecot/dovecot.conf
COPY ./conf/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
COPY ./conf/auth-passwdfile.conf.ext /etc/dovecot/conf.d/auth-passwdfile.conf.ext
COPY ./conf/auth-static.conf.ext /etc/dovecot/conf.d/auth-static.conf.ext
COPY ./conf/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY ./conf/10-master.conf /etc/dovecot/conf.d/10-master.conf
COPY ./conf/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf
COPY ./conf/virtual-mailbox /etc/postfix/virtual-mailbox
RUN postmap /etc/postfix/virtual-mailbox
COPY ./users /etc/dovecot/users

EXPOSE 25 110 143 465 587 993 995

CMD ["sh", "-c", "postfix start-fg & dovecot -F"]

