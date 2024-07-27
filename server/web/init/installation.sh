#!/bin/bash

dnf install -y httpd php-mysqlnd
dnf install -y epel-release
systemctl enable httpd
rm /etc/httpd/conf.d/welcome.conf 

dnf module reset php -y
dnf module enable php:8.2 -y
dnf module install php:8.2/common -y
dnf --enablerepo=epel -y install php-pear php-mbstring php-pdo php-gd php-mysqlnd php-IDNA_Convert php-enchant enchant hunspell
dnf install openssl -y
dnf install -y mod_ssl
dnf clean all

mkdir -p /var/www/wordpress
rmdir /var/www/html
cp /web/conf/httpd.conf /etc/httpd/conf/httpd.conf
cp /web/conf/www.conf /etc/php-fpm.d/www.conf
cp -r /web/wordpress /var/www/wordpress
chown -R apache. /var/www/wordpress
cp /web/cert/server.crt /etc/pki/tls/certs/server.crt
cp /web/cert/server.crt /etc/ssl/certs/server.crt
cp /web/cert/server.csr /etc/pki/tls/certs/server.csr
cp /web/cert/server.csr /etc/ssl/certs/server.csr
cp /web/cert/server.key /etc/pki/tls/certs/server.key
cp /web/cert/server.key /etc/ssl/certs/server.key
cp /web/conf/192.168.1.4-ssl.conf /etc/httpd/conf.d/192.168.1.4-ssl.conf
cp /web/conf/wordpress.conf /etc/httpd/conf.d/wordpress.conf
chmod 600 /etc/pki/tls/certs/server.key

# Test Apache configuration
apachectl configtest

systemctl php-fpm restart
systemctl httpd restart
