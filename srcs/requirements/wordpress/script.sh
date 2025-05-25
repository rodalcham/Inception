#!bin/bash

# wait for mysql to start
sleep 10

MYSQL_USER=$(cat "$MYSQL_USER_FILE")
MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")

echo $MYSQL_USER
echo $MYSQL_PASSWORD
echo $MYSQL_DATABASE
echo $MYSQL_HOSTNAME
echo $WP_URL
# Install Wordpress
if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root  --skip-check

    # wp core install --url=$domain_name --title=$brand --admin_user=$wordpress_admin \
    #     --admin_password=$wordpress_admin_password --admin_email=$wordpress_admin_email \
    #     --allow-root

    # wp user create $login $wp_user_email --role=author --user_pass=$wp_user_pwd --allow-root

	wp core install \
		--url="$WP_URL" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_pass/word="$WP_ADMIN_PWD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--allow-root

	# Add second user
	wp user create "$WP_USR" "$WP_EMAIL" \
		--user_pass="$WP_PWD" \
		--role=author \
		--allow-root

 #   wp config  set WP_DEBUG true  --allow-root

    wp config set FORCE_SSL_ADMIN 'false' --allow-root

    # wp config  set WP_REDIS_HOST $redis_host --allow-root

    # wp config set WP_REDIS_PORT $redis_port --allow-root

    # wp config  set WP_CACHE 'true' --allow-root

    # wp plugin install redis-cache --allow-root

    # wp plugin activate redis-cache --allow-root

    # wp redis enable --allow-root

    chmod 777 /var/www/html/wp-content

    # install theme

    wp theme install twentyfifteen

    wp theme activate twentyfifteen

    wp theme update twentyfifteen
fi


/usr/sbin/php-fpm7.3 -F

# #!/bin/sh
# set -e


# if [ -f wp-config.php ]
# then
# 	echo "wordpress already downloaded"
# else
# 	#Download wordpress config
# 	wget https://wordpress.org/latest.tar.gz
# 	tar -xzvf latest.tar.gz
# 	rm -rf latest.tar.gz


# 	#Inport env variables in the config file. This creates the wp-config.php file

# 	cd /var/www/html/wordpress
# 	chown -R www-data:www-data /var/www/html/wordpress
# 	find /var/www/html/wordpress -type d -exec chmod 755 {} \;
# 	find /var/www/html/wordpress -type f -exec chmod 644 {} \;

# 	# Set the WordPress URL and Home to your domain name
# 	sed -i "s|define('WP_HOME', 'http://localhost');|define('WP_HOME', 'https://rchavez.42.fr');|g" wp-config-sample.php
# 	sed -i "s|define('WP_SITEURL', 'http://localhost');|define('WP_SITEURL', 'https://rchavez.42.fr');|g" wp-config-sample.php
# 	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
# 	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
# 	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
# 	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
# 	mv wp-config-sample.php wp-config.php

# # cd /var/www/html

# # chown -R www-data:www-data /var/www/html/*

# # curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# # chmod +x wp-cli.phar
# # ./wp-cli.phar core download --allow-root
# # ./wp-cli.phar config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --allow-root
# # ./wp-cli.phar core install --url=localhost --title=inception --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
# # ./wp-cli.phar user create ${WP_USR} ${WP_EMAIL} --role=author --user_pass=${WP_PWD} --allow-root

# # 	#Update configuration file. This updates the www.conf file
# 	sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|' /etc/php/7.3/fpm/pool.d/www.conf
# fi

# # # Wait for MariaDB
# # # echo "Waiting for MariaDB..."
# # # until mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" > /dev/null 2>&# 1; do
# # # 	echo "Trying to connect"
# # # 	echo mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" > /dev/null
# # # 	mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" > /dev/null
# # # 	echo .
# # # 	sleep 1
# # # done

# # # Install WordPress core if not already installed
# if ! wp core is-installed --allow-root; then
# 	echo "Installing WordPress core..."
# 	wp core install \
# 		--url="$WP_URL" \
# 		--title="$WP_TITLE" \
# 		--admin_user="$WP_ADMIN_USER" \
# 		--admin_password="$WP_ADMIN_PWD" \
# 		--admin_email="$WP_ADMIN_EMAIL" \
# 		--allow-root

# 	# Add second user
# 	wp user create "$WP_USR" "$WP_EMAIL" \
# 		--user_pass="$WP_PWD" \
# 		--role=author \
# 		--allow-root
# fi
# # # USERS SHOULD BE SECRET????

# cat << EOF > /etc/php/7.3/fpm/pool.d/www.conf
# 	[global]
# 	pid = /run/php/php7.3-fpm.pid
# 	error_log = /dev/stdout
# 	log_level = notice
# 	[www]
# 	clear_env = no
# 	user = www-data
# 	group = www-data
# 	listen = 0.0.0.0:9000
# 	listen.owner = www-data
# 	listen.group = www-data
# 	pm = dynamic
# 	pm.max_children = 5
# 	pm.start_servers = 2
# 	pm.min_spare_servers = 1
# 	pm.max_spare_servers = 3
# EOF


# # # sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|' /etc/php/7.3/fpm/pool.d/www.conf

# # echo "Wordpress is up and running"

# mkdir -p /run/php
# exec /usr/sbin/php-fpm7.3 -F