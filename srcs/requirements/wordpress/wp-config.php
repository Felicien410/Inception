#!/bin/sh

# Le chemin où se trouve votre wp-config.php (dans le conteneur)
WP_CONFIG="/var/www/html/wp-config.php"

# Télécharger la clé unique de salage de WordPress
WP_SALT=$(wget -qO- https://api.wordpress.org/secret-key/1.1/salt/)

# Utiliser les variables d'environnement pour les informations de la base de données
WP_DATABASE_NAME=${WP_DATABASE_NAME:-wordpress}
WP_DATABASE_USR=${WP_DATABASE_USR:-user}
WP_DATABASE_PWD=${WP_DATABASE_PWD:-password}
DB_HOST=${DB_HOST:-mariadb}

define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
@ini_set('display_errors', 0);

# Créer le fichier wp-config.php à partir de wp-config-sample.php
cp /var/www/html/wp-config-sample.php "$WP_CONFIG"

# Configurer les informations de base de données
sed -i "s/database_name_here/$WP_DATABASE_NAME/" "$WP_CONFIG"
sed -i "s/username_here/$WP_DATABASE_USR/" "$WP_CONFIG"
sed -i "s/password_here/$WP_DATABASE_PWD/" "$WP_CONFIG"
sed -i "s/localhost/$DB_HOST/" "$WP_CONFIG"

# Configurer les clés de salage uniques
printf '%s\n' "g/$table_prefix = 'wp_';/r /dev/stdin" . x | ex "$WP_CONFIG" <<< "$WP_SALT"

# Ajouter des configurations supplémentaires si nécessaire
# ...

# Démarrer PHP-FPM
php-fpm8 -F
