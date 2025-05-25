#!/bin/bash
set -e

echo "Waiting for MariaDB..."
while ! mysqladmin ping -h mariadb -u wp_user -p$(cat /run/secrets/db_password) --silent; do
    echo "MariaDB not ready yet..."
    sleep 1
done
echo "MariaDB is alive"

echo "Setting up WordPress..."
mkdir -p /var/www/html
cd /var/www/html

if [ ! -f /var/www/html/index.php ]; then
    echo "Installing fresh WordPress..."
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz
fi

echo "Configuring WordPress files..."
cp /usr/local/bin/wp-config.php /var/www/html/wp-config.php
chown -R www-data:www-data /var/www/html
chmod 640 /var/www/html/wp-config.php

echo "Exporting DB_PASSWORD..."
export DB_PASSWORD=your_password

echo "Starting PHP-FPM..."
# Add debug to see if it starts
php-fpm7.4 -F || { echo "PHP-FPM failed to start"; exit 1; }
