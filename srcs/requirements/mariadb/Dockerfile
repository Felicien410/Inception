FROM alpine:3.18.0

RUN apk update && \
    apk add --no-cache mariadb mariadb-client

RUN			apk add openrc
RUN which mysql_upgrade || echo "mysql_upgrade not found"
# Créer le répertoire pour le socket MySQL et définir les permissions
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
RUN mkdir -p /var/log/mysql/ && chown -R mysql:mysql /var/log/mysql/

# Copier le fichier de configuration personnalisé dans le conteneur
COPY my-custom.cnf /etc/mysql/my.cnf
COPY my-custom.cnf /etc/my.cnf
COPY start.sh /tmp/start.sh
RUN			chmod +x /tmp/start.sh

CMD ["sh", "/tmp/start.sh"]

EXPOSE		3306