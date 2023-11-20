FROM alpine:3.16.0

# Installer PHP et les extensions nécessaires
RUN apk add --no-cache \
    php8 \
    php8-fpm \
    php8-opcache \
    php8-mysqli \
    php8-json \
    php8-openssl \
    php8-curl \
    php8-zlib \
    php8-xml \
    php8-phar \
    php8-intl \
    php8-dom \
    php8-xmlreader \
    php8-ctype \
    php8-session \
    php8-mbstring \
    php8-gd \
    wget \
    mariadb-client

RUN mkdir -p /var/www/html
RUN adduser -S nginx &&	addgroup -S nginx

# Télécharger WordPress et le déplacer dans le répertoire de travail
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz -C /var/www/ && \
    rm latest.tar.gz && \
    mv /var/www/wordpress/* /var/www/html/ && \
    rmdir /var/www/wordpress && \
    chown -R nginx:nginx /var/www/html

# Copier le script de configuration
COPY index.html /tmp/index.html
COPY wp-config.php /var/www/html/wp-config.php
COPY www.conf /etc/php8/php-fpm.d/www.conf
COPY configure.sh /configure.sh
RUN chmod +x /configure.sh
RUN chmod +x /var/www/html/wp-config.php
RUN chmod +x /tmp/index.html

# Exposer le port sur lequel PHP-FPM écoute
EXPOSE 9000

# Utiliser le répertoire /var/www/html comme répertoire de travail
WORKDIR /var/www/html

# Démarrer PHP-FPM
CMD ["sh", "/configure.sh"]
