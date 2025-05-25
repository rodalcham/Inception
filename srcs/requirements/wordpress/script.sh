#!bin/bash

# wait for mysql to start
sleep 10

MYSQL_USER=$(cat "$MYSQL_USER_FILE")
MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
WP_USR=$(cat $WP_USR_FILE)
WP_PWD=$(cat $WP_PWD_FILE)
WP_EMAIL=$(cat $WP_EMAIL_FILE)
WP_ADMIN_USER=$(cat $WP_ADMIN_USER_FILE)
WP_ADMIN_PWD=$(cat $WP_ADMIN_PWD_FILE)
WP_ADMIN_EMAIL=$(cat $WP_ADMIN_EMAIL_FILE)

# Install Wordpress
if [ ! -f /var/www/html/wp-config.php ]; then
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root  --skip-check

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

	# Create a "Welcome" page with a Login link
	wp menu create "Main Menu" --allow-root
	wp menu item add-custom "Main Menu" "Login" "$WP_URL/wp-login.php" --allow-root
	wp theme mod set nav_menu_locations.main_menu "Main Menu" --allow-root

	wp config set FORCE_SSL_ADMIN 'false' --allow-root


	chmod 777 /var/www/html/wp-content

	# install theme

	wp theme install twentyfifteen --allow-root

	wp theme activate twentyfifteen --allow-root

	wp theme update twentyfifteen --allow-root
fi


/usr/sbin/php-fpm7.3 -F
