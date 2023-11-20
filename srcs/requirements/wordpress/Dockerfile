FROM alpine:3.14.0

RUN		apk update
RUN		apk upgrade

RUN		apk add php7 \
				php7-fpm \
				php7-opcache \
				php7-mysqli \
				php7-session \
				php7-iconv \
				php7-json \
				php7-gd \
				php7-curl \
				php7-xml \
				php7-common \
				php7-imap \
				php7-cgi \
				php7-pdo \
				php7-pdo_mysql \
				php7-soap \
				php7-xmlrpc \
				php7-posix \
				php7-mcrypt \
				php7-redis \
				php7-gettext \
				php7-ldap \
				php7-ctype \
				php7-dom \
				php7-phar \
				php7-gd \
				php7-zlib

RUN		apk add curl wget
RUN		apk add openrc

RUN		rm -f /etc/php7/php-fpm.d/www.conf
COPY	conf/default.conf /etc/php7/php-fpm.d/www.conf

RUN		mkdir 					-p /var/www/html
RUN		adduser 				-u 82 -D -S -G www-data www-data
RUN		chmod 777 				-R /var/www/html
RUN		chown 					-R www-data:www-data /var/www/html

COPY	./conf/wp-config.php	./
COPY	./conf/configure.sh	./
COPY conf/index.html /tmp/index.html

RUN		chmod +x 				./configure.sh
ENTRYPOINT [ "sh", "/tmp/configure.sh" ]

EXPOSE	9000