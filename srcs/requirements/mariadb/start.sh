#!/bin/sh

# Initialisation de MariaDB
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Lancement de MariaDB en arrière-plan
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

# Attente que MariaDB soit lancé
while ! mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

# Création de la base de données et de l'utilisateur
mysql -e "CREATE DATABASE IF NOT EXISTS \${DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '\${DB_USER}'@'%' IDENTIFIED BY '\${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \${DB_NAME}.* TO '\${DB_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

mysql -e "SHOW DATABASES;" | grep ${DB_NAME}
mysql -e "SELECT user FROM mysql.user;" | grep ${DB_USER}
mysql -e "SHOW GRANTS FOR '${DB_USER}'@'%';"


# Arrêt propre de MariaDB
if ! wait %1; then
    mysqladmin -uroot shutdown
fi
