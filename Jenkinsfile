pipeline {
    agent {
        docker {
            image 'node:18'
        }
    }
    stages {
        stage('Cloner le dépôt') {
            steps {
                git 'https://github.com/mousaab02/projetfe.git'
            }
        }

        stage('Installer les dépendances') {
            steps {
                dir('backend') {
                    sh 'npm install'
                }
            }
        }

        stage('Lancer les tests') {
            steps {
                dir('backend') {
                    sh 'npm test'
                }
            }
        }

        stage('Démarrer l\'application') {
            steps {
                dir('backend') {
                    sh 'node server.js'
                }
            }
        }
    }
}
