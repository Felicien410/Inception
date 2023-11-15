#!/bin/sh

# Le chemin où se trouve votre wp-config.php (dans le conteneur)
WP_CONFIG="/var/www/html/wp-config.php"

# Télécharger la clé unique de salage de WordPress
WP_SALT=$(wget -qO- https://api.wordpress.org/secret-key/1.1/salt/)

# Utiliser les variables d'environnement pour les informations de la base de données
DB_NAME=${DB_NAME:-wordpress}
DB_USER=${DB_USER:-user}
DB_PASSWORD=${DB_PASSWORD:-password}
DB_HOST=${DB_HOST:-mariadb}

# Créer le fichier wp-config.php à partir de wp-config-sample.php
cp /var/www/html/wp-config-sample.php "$WP_CONFIG"

# Configurer les informations de base de données
sed -i "s/database_name_here/$DB_NAME/" "$WP_CONFIG"
sed -i "s/username_here/$DB_USER/" "$WP_CONFIG"
sed -i "s/password_here/$DB_PASSWORD/" "$WP_CONFIG"
sed -i "s/localhost/$DB_HOST/" "$WP_CONFIG"

# Configurer les clés de salage uniques
printf '%s\n' "g/$table_prefix = 'wp_';/r /dev/stdin" . x | ex "$WP_CONFIG" <<< "$WP_SALT"

# Ajouter des configurations supplémentaires si nécessaire
# ...

# Démarrer PHP-FPM
php-fpm8 -F
