# Utilise une image Node.js officielle
FROM node:18

# Crée un dossier de travail dans le conteneur
WORKDIR /app

# Copie les fichiers package.json et package-lock.json
COPY package*.json ./

# Installe les dépendances
RUN npm install

# Copie tout le code source
COPY . .

# Expose le port sur lequel l'app écoute
EXPOSE 3000

# Commande pour démarrer l'app
CMD ["node", "server.js"]
