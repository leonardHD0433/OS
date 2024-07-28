#!/bin/bash

# Create the /run/php-fpm directory if it doesn't exist
if [ ! -d /run/php-fpm ]; then
    mkdir -p /run/php-fpm
    chown -R apache:apache /run/php-fpm
    chmod 755 /run/php-fpm
fi

if [ ! -f /var/www/wordpress/info.php ]; then
    echo "<?php phpinfo(); ?>" > /var/www/wordpress/info.php
    chown apache:apache /var/www/wordpress/info.php
    chmod 644 /var/www/wordpress/info.php
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    cp -v /web/conf/wp-config.php /var/www/wordpress/
    chown apache:apache /var/www/wordpress/wp-login.php
    chmod 644 /var/www/wordpress/wp-login.php
fi

# Start httpd in the background
httpd -D FOREGROUND &

# Start php-fpm in the foreground
php-fpm -F