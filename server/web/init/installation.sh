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
dnf install -y php-fpm
dnf install -y tar
dnf clean all

cp /web/tar/wordpress-6.6.1.tar.gz /var/www/wordpress-6.6.1.tar.gz
tar zxvf /var/www/latest.tar.gz -C /var/www/
chown -R apache. /var/www/wordpress
cp /web/conf/httpd.conf /etc/httpd/conf/httpd.conf
cp /web/conf/www.conf /etc/php-fpm.d/www.conf
cp /web/conf/wordpress.conf /etc/httpd/conf.d/wordpress.conf
rm /etc/httpd/conf.d/ssl.conf
#cp /web/conf/192.168.1.4-ssl.conf /etc/httpd/conf.d/192.168.1.4-ssl.conf

# Test Apache configuration
apachectl configtest
