# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: feliciencatteau <feliciencatteau@studen    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/06 16:41:34 by shovsepy          #+#    #+#              #
#    Updated: 2023/11/15 08:55:14 by feliciencat      ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

# Vérifier si la base de données a déjà été initialisée
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql 
fi

mysqld_safe --datadir='/var/lib/mysql' &

# Augmenter le délai d'attente
sleep 20

echo "DB_NAME: ${DB_NAME}"
echo "DB_USER: ${DB_USER}"
echo "DB_PASSWORD: ${DB_PASSWORD}"

mysql -u root -e "DELETE FROM	mysql.user WHERE User='';"
mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

mysqladmin shutdown


# Allowing network connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld_safe --datadir='/var/lib/mysql'
