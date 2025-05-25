#!/bin/sh
set -e

MYSQL_USER=$(cat "$MYSQL_USER_FILE")
MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")

if [ -f wp-config.php ]
then
	echo "wordpress already downloaded"
else
	#Download wordpress config
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz


	#Inport env variables in the config file. This creates the wp-config.php file
	cd /var/www/html/wordpress
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	mv wp-config-sample.php wp-config.php

	#Update configuration file. This updates the www.conf file
	sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|' /etc/php/7.3/fpm/pool.d/www.conf
fi

# Wait for MariaDB
# echo "Waiting for MariaDB..."
# until mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" > /dev/null 2>&# 1; do
# 	echo "Trying to connect"
# 	echo mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" > /dev/null
# 	mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" > /dev/null
# 	echo .
# 	sleep 1
# done

# Install WordPress core if not already installed
if ! wp core is-installed --allow-root; then
	echo "Installing WordPress core..."
	wp core install \
		--url="$WP_URL" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PWD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--allow-root

	# Add second user
	wp user create "$WP_USR" "$WP_EMAIL" \
		--user_pass="$WP_PWD" \
		--role=author \
		--allow-root
fi
# USERS SHOULD BE SECRET????

cat << EOF > /etc/php/7.3/fpm/pool.d/www.conf
	[global]
	pid = /run/php/php7.3-fpm.pid
	error_log = /dev/stdout
	log_level = notice
	[www]
	clear_env = no
	user = www-data
	group = www-data
	listen = 0.0.0.0:9000
	listen.owner = www-data
	listen.group = www-data
	pm = dynamic
	pm.max_children = 5
	pm.start_servers = 2
	pm.min_spare_servers = 1
	pm.max_spare_servers = 3
EOF


# sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|' /etc/php/7.3/fpm/pool.d/www.conf

echo "Wordpress is up and running"

mkdir -p /run/php
exec /usr/sbin/php-fpm7.3 -F