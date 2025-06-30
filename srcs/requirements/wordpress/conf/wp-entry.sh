#!/bin/bash
set -e

MAX_RETRIES=30
COUNT=0
until mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1"; do
    echo "Waiting for MariaDB... (Attempt $((COUNT + 1))/$MAX_RETRIES)"
    COUNT=$((COUNT + 1))
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "Error: MariaDB connection timed out after $MAX_RETRIES attempts"
        exit 1
    fi
    sleep 3
done

if [ ! -f wp-config.php ]; then
    echo "Installing WordPress"
    wp core download 
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST"
    wp core install \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL"
    wp theme activate twentytwentyfour
    wp rewrite structure '/%postname%/'
fi

exec "$@"