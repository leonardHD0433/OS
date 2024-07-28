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
dnf install -y mariadb-client
dnf install -y mod_ssl
dnf install -y php-fpm
dnf install -y tar
dnf clean all

mkdir -p /var/www/wordpress
mkdir -p /run/php-fpm
cp -r /web/wordpress/* /var/www/wordpress

