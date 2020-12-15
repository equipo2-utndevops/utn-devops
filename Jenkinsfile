pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh 'git clone -b unidad-4 https://github.com/equipo2-utndevops/webapp.git || true'
                sh 'cd webapp'
                sh 'curl -sS https://getcomposer.org/installer | php'
                sh 'php composer.phar install'
                sh 'chmod -R 777 storage bootstrap/cache'
            }
        }
        stage('Build') {
            steps {
                sh 'find . -path ./webapp/app/vendor -prune -o -name \\*.php -exec php -l "{}" \\;'
                retry(2) {
                    sh 'cd webapp/app && sudo php -dmemory_limit=750M /usr/local/bin/composer update --no-scripts --prefer-dist'
                }
            }
        }
        stage('Test') {
            steps {
                sh './webapp/app/vendor/bin/phpunit -c ./webapp/phpunit.xml'
            }
        }
    }
}