# Utiliser Alpine Linux comme image de base
FROM alpine:3.16.0

# Mettre à jour la liste des paquets et installer les dépendances
RUN apk update && apk add --no-cache nginx openssl

# Créer un répertoire pour les fichiers de configuration de NGINX et les certificats SSL
RUN mkdir -p /run/nginx /etc/nginx/ssl

# Générer un certificat SSL auto-signé pour TLSv1.2 et TLSv1.3
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/Inception.key \
    -out /etc/nginx/ssl/Inception.crt \
    -subj "/C=FR/ST=Mouvaux/L=Mouvaux/O=42Nice/OU=fcatteau/CN=Inception"

# Ajouter la configuration personnalisée de NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Exposer le port 443 pour le trafic HTTPS
EXPOSE 443

# Commande pour démarrer NGINX en premier plan
CMD ["nginx", "-g", "daemon off;"]