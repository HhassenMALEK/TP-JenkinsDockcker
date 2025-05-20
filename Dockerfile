# Étape 1 : On utilise une image de base ultra légère basée sur Alpine Linux avec Nginx préinstallé.
# Pourquoi Alpine ? Parce qu'elle est minuscule (5 Mo env.), donc rapide à télécharger et plus sécurisée.
FROM nginx:alpine

# Étape 2 : On copie le fichier index.html de ton projet local dans le dossier où Nginx sert les fichiers web.
# C’est-à-dire : on remplace la page d'accueil par défaut de Nginx avec TON fichier HTML.
COPY index.html /usr/share/nginx/html/index.html