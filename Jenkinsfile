pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh 'git clone -b https://github.com/equipo2-utndevops/webapp || true'
                sh 'cd webapp && sudo git checkout unidad-4'
                sh 'cd web-app/app && sudo /usr/local/bin/composer install'
                sh 'chmod 777 ./webapp/app/bootstrap/cache/'
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