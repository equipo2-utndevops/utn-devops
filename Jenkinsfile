pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh 'git clone -b unidad-4 https://github.com/equipo2-utndevops/webapp.git || true'
                sh 'cd webapp && curl -sS https://getcomposer.org/installer | php'
                sh 'cd webapp && php composer.phar install'
                sh 'cd webapp && chmod -R 777 storage bootstrap/cache'
            }
        }
        stage('Build') {
            steps {
                sh 'find . -path ./webapp/app/vendor -prune -o -name \\*.php -exec php -l "{}" \\;'
                retry(2) {
                    sh 'cd webapp && sudo php -dmemory_limit=750M composer.phar update --no-scripts --prefer-dist'
                }
            }
        }
        stage('Test') {
            steps {
                sh './vendor/bin/phpunit tests/Unit'
            }
        }
    }
}