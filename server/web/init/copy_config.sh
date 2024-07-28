#!/bin/bash

# Define paths
CERT_DIR="/etc/pki/tls/certs"
KEY_FILE="$CERT_DIR/server.key"
CSR_FILE="$CERT_DIR/server.csr"
CRT_FILE="$CERT_DIR/server.crt"

cp /web/conf/index.php /var/www/wordpress/index.php
cp /web/conf/www.conf /etc/php-fpm.d/www.conf
cp /web/conf/wordpress.conf /etc/httpd/conf.d/wordpress.conf
rm /etc/httpd/conf.d/ssl.conf

cp /web/cert/server.key $KEY_FILE
cp /web/cert/server.csr $CSR_FILE
cp /web/cert/server.crt $CRT_FILE

cp $KEY_FILE /etc/ssl/certs/server.key
cp $CRT_FILE /etc/ssl/certs/server.crt

cp /web/conf/192.168.1.4-ssl.conf /etc/httpd/conf.d/192.168.1.4-ssl.conf
cp /web/conf/httpd.conf /etc/httpd/conf/httpd.conf

# Test Apache configuration
apachectl configtest