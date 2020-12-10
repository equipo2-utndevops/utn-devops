#!/usr/bin/env bash

#ENV VARIABLES 
export APP="/data/app/"
export DB="/data/db/"
export SHARED="/vagrant/"

#INSTALL DOCKER AND DOCKER compose
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#INSTALL MYSQL CLIENT
#sudo apt install -y mysql-client-core-5.7

#install php y composer 
sudo apt-get install zip unzip php-zip -y
sudo apt-get install php7.2-cli -y
sudo apt-get install php7.2-mbstring -y
sudo apt-get install php-xml -y

#CREATE DOCKER VOLUME DIRECTORIES
mkdir -m 777 -p $APP
mkdir -m 777 -p $DB

#COPY APP FILES
cd $APP
git clone -b unidad-4 https://github.com/equipo2-utndevops/webapp
cd webapp
sudo curl -sS https://getcomposer.org/installer | php
sudo chmod -R 777 storage bootstrap/cache
cp .env.example .env
sudo php composer.phar update -n -q
sudo php composer.phar clear
sudo php composer.phar dump-autoload
sudo php artisan key:generate
cd ..
shopt -s dotglob
mv webapp/* .
rm -rf webapp

#COPY FILES AND RUN DOCKER-COMPOSE
cd $SHARED
docker build -t php-apache-mysql dockerfiles/apache/.
docker build -t mysql-with-tables dockerfiles/mysql/. 
cd dockerfiles/compose
sudo docker-compose up -d 
