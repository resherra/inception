#!/bin/bash
set -e

MAX_RETRIES=30
COUNT=0
until mariadb -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1"; do
    echo "Waiting for MariaDB... (Attempt $((COUNT + 1))/$MAX_RETRIES)"
    COUNT=$((COUNT + 1))
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "Error: MariaDB connection timed out after $MAX_RETRIES attempts"
        mariadb -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1" 2>&1
        exit 1
    fi
    sleep 3
done

if [ ! -f wp-config.php ]; then
    echo "Installing WordPress"
    wp core download --allow-root
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root
    wp core install \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --allow-root
fi

exec "$@"
