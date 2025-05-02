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
mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

echo "MDB IS UP AND RUNNING"

exec "$@"