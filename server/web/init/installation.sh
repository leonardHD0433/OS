#!/bin/bash

# Define paths
CERT_DIR="/etc/pki/tls/certs"
KEY_FILE="$CERT_DIR/server.key"
CSR_FILE="$CERT_DIR/server.csr"
CRT_FILE="$CERT_DIR/server.crt"

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
dnf install -y php-fpm
dnf install -y tar
dnf clean all

cp /web/tar/wordpress-6.6.1.tar.gz /var/www/wordpress-6.6.1.tar.gz
tar zxvf /var/www/wordpress-6.6.1.tar.gz -C /var/www/
chown -R apache. /var/www/wordpress
cp /web/conf/httpd.conf /etc/httpd/conf/httpd.conf
cp /web/conf/www.conf /etc/php-fpm.d/www.conf
cp /web/conf/wordpress.conf /etc/httpd/conf.d/wordpress.conf
rm /etc/httpd/conf.d/ssl.conf

cp /web/cert/server.key $KEY_FILE
cp /web/cert/server.csr $CSR_FILE
cp /web/cert/server.crt $CRT_FILE

# Set permissions
chmod 600 $KEY_FILE

cp $KEY_FILE /etc/ssl/certs/server.key
cp $CRT_FILE /etc/ssl/certs/server.crt

chmod 600 /etc/ssl/certs/server.key

cp /web/conf/192.168.1.4-ssl.conf /etc/httpd/conf.d/192.168.1.4-ssl.conf

# Test Apache configuration
apachectl configtest
