# Utiliser Alpine Linux comme image de base
FROM alpine:3.18.0

# Installer Nginx et OpenSSL
RUN apk update && \
    apk add --no-cache nginx openssl

# Créer un répertoire pour les fichiers de configuration de NGINX et les certificats SSL
RUN mkdir -p /run/nginx /etc/nginx/ssl

# Générer un certificat SSL auto-signé pour TLSv1.2 et TLSv1.3
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Nord/L=Mouvaux/O=42/OU=fcatteau/CN=localhost"

# Ajouter la configuration personnalisée de NGINX
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# Commande pour démarrer NGINX en premier plan
CMD ["nginx", "-g", "daemon off;"]