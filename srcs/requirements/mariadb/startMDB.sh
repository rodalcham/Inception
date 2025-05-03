#!/bin/bash

service mysql start


# echo "$@"

# Wait for MySQL to be available via socket
while [ ! -S /var/run/mysqld/mysqld.sock ]; do
    echo "Waiting for MySQL to be ready..."
    sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
# mysql -uroot -p -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mysql -uroot -e "SHOW VARIABLES LIKE 'validate_password%';"
# mysql -uroot -e "SELECT user, host, authentication_string FROM mysql.user WHERE user = 'root';"
# mysql -uroot -e "SELECT user, host, authentication_string FROM mysql.user WHERE user = 'root';"
# mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';"
mysql -uroot -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"
# echo "Root Password: ${MYSQL_ROOT_PASSWORD}"
# echo "'${MYSQL_ROOT_PASSWORD}'"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown
echo "MDB IS UP AND RUNNING"

exec "$@"