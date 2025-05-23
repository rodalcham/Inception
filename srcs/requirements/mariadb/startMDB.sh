#!/bin/bash

set -e

service mysql start


MYSQL_ROOT_PASSWORD=$(< "$MYSQL_ROOT_PASSWORD_FILE")
MYSQL_USER=$(< "$MYSQL_USER_FILE")
MYSQL_PASSWORD=$(< "$MYSQL_PASSWORD_FILE")

while [ ! -S /var/run/mysqld/mysqld.sock ]; do
    echo "Waiting for MySQL to be ready..."
    sleep 1
done


if [ ! -f /var/lib/mysql/.mdb_initialized ]; then
    echo "Running initial DB setup..."

    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

    mysql -uroot -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"

    touch /var/lib/mysql/.mdb_initialized
fi

sleep 2

mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown
echo "MDB IS UP AND RUNNING"
exec "$@"