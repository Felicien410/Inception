# Choisir une image de base qui inclut PHP et php-fpm sur Alpine
FROM php:8.1-fpm-alpine

COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf

# Installer les dépendances PHP et les extensions nécessaires pour WordPress
RUN docker-php-ext-install pdo pdo_mysql

# Télécharger et décompresser WordPress dans le répertoire /var/www/html
RUN curl -o wordpress.tar.gz -fSL "https://wordpress.org/latest.tar.gz" \
    && tar -xzf wordpress.tar.gz -C /var/www/html/ \
    && rm wordpress.tar.gz \
    && chown -R www-data:www-data /var/www/html/wordpress

# S'assurer que les fichiers et dossiers sont accessibles
RUN chown -R www-data:www-data /var/www/html

# Exposer le port sur lequel php-fpm écoute par défaut (9000)
EXPOSE 9000

# Utiliser php-fpm comme processus principal
CMD ["php-fpm"]

