#!/bin/sh

# Assume that WP core files are already in /var/www/html
while ! mariadb -h ${DB_HOST} -u ${DB_USER} -p${DB_PASSWORD} -e "SELECT 1" &> /dev/null; do
    echo "En attente de la base de données..."
    sleep 3
done

echo "Base de données accessible, configuration de WordPress en cours..."


# Set the database details with the ENV variables
sed -i "s|database_name_here|${DB_NAME}|" wp-config.php
sed -i "s|username_here|${DB_USER}|" wp-config.php
sed -i "s|password_here|${DB_PASSWORD}|" wp-config.php
sed -i "s|localhost|${DB_HOST}|" wp-config.php

# Set the AUTH_KEY, SECURE_AUTH_KEY, and other security keys
AUTH_KEY='votre_clé_auth_key_ici'
sed -i "s|'AUTH_KEY', 'put your unique phrase here'|${AUTH_KEY}|" wp-config.php
# Répétez cette opération pour les autres clés
# Par exemple, pour SECURE_AUTH_KEY:
# SECURE_AUTH_KEY=$(commande pour obtenir la clé)
# sed -i "s|'SECURE_AUTH_KEY', 'put your unique phrase here'|${SECURE_AUTH_KEY}|" wp-config.php
# ... et ainsi de suite pour les autres clés

# Set WP_DEBUG to true if environment variable is set to 'true'
if [ "$WP_DEBUG" = 'true' ]; then
   sed -i "s|WP_DEBUG', false|WP_DEBUG', true|" wp-config.php
fi

# Set the table prefix if WP_TABLE_PREFIX variable is set
if [ ! -z "$WP_TABLE_PREFIX" ]; then
   sed -i "s|\$table_prefix  = 'wp_';|\$table_prefix  = '${WP_TABLE_PREFIX}_';|" wp-config.php
fi

echo "=> WordPress has been configured! on port 9000"
# Start PHP-FPM
exec php-fpm8 -F
