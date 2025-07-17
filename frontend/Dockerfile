# Utilise une image officielle Nginx
FROM nginx:alpine

# Supprime la config par défaut de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copie ton code HTML statique dans le bon dossier
COPY . /usr/share/nginx/html

# Expose le port par défaut
EXPOSE 80

# Pas besoin de CMD, Nginx s’exécute déjà par défaut
