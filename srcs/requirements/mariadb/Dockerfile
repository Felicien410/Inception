FROM alpine:3.16.0

RUN apk update && \
    apk add --no-cache mariadb mariadb-client

# RUN mkdir -p /var/lib/mysql

# RUN mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

COPY start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 3306

CMD ["sh", "/start.sh"]

