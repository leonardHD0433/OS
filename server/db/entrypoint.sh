#!/bin/bash
set -e

# Debug: Print the MYSQL_ROOT_PASSWORD
echo "MYSQL_ROOT_PASSWORD is set to: $MYSQL_ROOT_PASSWORD"

# Set the correct permissions for the SQL file
chmod 644 /docker-entrypoint-initdb.d/database_creation.sql

# Execute the original entrypoint script from the MariaDB image
docker-entrypoint.sh mysqld &

# Wait for the MariaDB server to start
until mysqladmin ping -h "localhost" --silent; do
    echo 'waiting for mysqld to be connectable...'
    sleep 2
done

# Execute the SQL script
mariadb -u root -p"$MYSQL_ROOT_PASSWORD" < /docker-entrypoint-initdb.d/database_creation.sql

# Bring the MariaDB server to the foreground
wait
