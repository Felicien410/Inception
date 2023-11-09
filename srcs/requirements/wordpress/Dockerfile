FROM alpine:3.16.0

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

# Ajouter l'utilisateur www-data si nécessaire et l'ajouter au groupe www-data
RUN adduser -D -H -u 82 -s /sbin/nologin -G www-data www-data || true

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz \
    && chown -R www-data:www-data /var/www/html

COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

COPY ./wp-config.php /var/www/html/wordpress

EXPOSE 9000

RUN chmod -R 755 /var/www/html/wordpress

CMD ["php-fpm8", "-F"]



