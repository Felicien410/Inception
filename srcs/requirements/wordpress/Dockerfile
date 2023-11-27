FROM alpine:3.18.0

RUN		apk update
RUN		apk upgrade

#==== PHP_FPM =================================================================#
RUN apk add php81 \
            php81-fpm \
            php81-opcache \
            php81-mysqli \
            php81-session \
            php81-iconv \
            php81-json \
            php81-gd \
            php81-curl \
            php81-xml \
            php81-common \
            php81-imap \
            php81-cgi \
            php81-pdo \
            php81-pdo_mysql \
            php81-soap \
            php81-posix \
            php81-redis \
            php81-gettext \
            php81-ldap \
            php81-ctype \
            php81-dom \
            php81-phar \
            php81-gd \
            php81-zlib

RUN		apk add curl wget
RUN		apk add openrc

RUN rm -f /etc/php81/php-fpm.d/www.conf
COPY conf/default.conf /etc/php81/php-fpm.d/www.conf

#==== WORDPRESS ===============================================================#
RUN		mkdir 					-p /var/www/html
RUN		adduser 				-u 82 -D -S -G www-data www-data
RUN		chmod 777 				-R /var/www/html
RUN		chown 					-R www-data:www-data /var/www/html

COPY	./conf/wp-config.php	./
COPY	./conf/configure.sh	./

RUN		chmod +x 				./configure.sh
ENTRYPOINT						["./configure.sh"]

#==============================================================================#
EXPOSE	9000