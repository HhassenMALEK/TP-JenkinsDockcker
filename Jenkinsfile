// la déclaration de pipeline (pipeline déclaratif)
pipeline {
    
    // L’agent définit sur quelle machine Jenkins exécutera ce pipeline (ici "any" = n’importe quel agent disponible)
    agent any

    // Déclaration des variables d’environnement utilisables dans tout le pipeline
    environment {
        IMAGE_NAME = 'monsite-Docker'                         // Nom de l'image Docker à construire
        CONTAINER_NAME = 'monsite-Docker-conteneur'           // Nom du conteneur à créer
        GIT_REPO = 'https://github.com/HhassenMALEK/TP-JenkinsDockcker' // URL du repo GitHub à cloner
    }

    // Définition des différentes étapes du pipeline
    stages {
        
        // Étape 1 : Clonage du dépôt GitHub
        stage('Cloner le repo') {
            steps {
                git branch: 'main', url: "${env.GIT_REPO}"// Clone le dépôt depuis l’URL 
            }
        }

        // Étape 2 : Vérification des fichiers essentiels
        stage('Vérification des fichiers') {
            steps {
                script {
                    // Si Dockerfile ou index.html est manquant, le pipeline s'arrête avec une erreur
                    if (!fileExists('Dockerfile') || !fileExists('index.html')) {
                        error("Fichiers Dockerfile ou index.html manquants.")
                    }
                }
            }
        }

        // Étape 3 : Construction de l'image Docker à partir du Dockerfile
        stage('Construire l’image Docker') {
            steps {
                script {
                    // Lance la commande de build Docker avec le nom d’image défini
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        // Étape 4 : Suppression du conteneur existant (s’il existe)
        stage('Supprimer l’ancien conteneur') {
            steps {
                script {
                    // Supprime le conteneur en forçant la suppression (|| true évite l’échec si le conteneur n'existe pas)
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                }
            }
        }

        // Étape 5 : Lancement d’un nouveau conteneur à partir de l’image construite
        stage('Déployer le conteneur') {
            steps {
                script {
                    // Démarre le conteneur en détaché (-d), expose le port 8081 en local vers le port 80 du conteneur
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}"
                }
            }
        }
    }

    // Bloc exécuté à la fin du pipeline, peu importe l'état de la build
    post {
        // Si tout s’est bien passé
        success {
            echo "Déploiement réussi ! Le site est disponible sur : http://<IP_Jenkins>:8081"
        }
        // Si une étape a échoué
        failure {
            echo "Le déploiement a échoué !"
        }
    }
}
