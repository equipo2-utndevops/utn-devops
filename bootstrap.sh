#!/usr/bin/env bash

# update
sudo apt-get update -y

# -Desinstalar el software instalado de la práctica 01.
#  des-instala nginx
sudo apt-get remove --purge -y nginx
sudo apt autoremove -y

# Se genera una partición swap. Previene errores de falta de memoria
if [ ! -f "/swapdir/swapfile" ]; then
	sudo mkdir /swapdir
	cd /swapdir
	sudo dd if=/dev/zero of=/swapdir/swapfile bs=1024 count=2000000
	sudo mkswap -f  /swapdir/swapfile
	sudo chmod 600 /swapdir/swapfile
	sudo swapon swapfile
	echo "/swapdir/swapfile       none    swap    sw      0       0" | sudo tee -a /etc/fstab /etc/fstab
	sudo sysctl vm.swappiness=10
	echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
fi

#INSTALL DOCKER AND DOCKER compose
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo chkconfig enable docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


#COPY FILES AND RUN DOCKER-COMPOSE
#cp /vagrant/Dockerfile .
docker build . -t php-apache-mysql
#cp /vagrant/index.php .
#cp /vagrant/docker-compose.yml .
sudo docker-compose up





# # ruta raíz del servidor web
# WEB_ROOT="/var/www"
# # ruta de la aplicación
# APP_PATH="$WEB_ROOT/practica01"

# # Se crea el directorio del sitio
# sudo mkdir $APP_PATH

# # Se clona la aplicación del repo
# cd $WEB_ROOT
# sudo git clone https://github.com/equipo2-utndevops/practica01.git
# cd $APP_PATH
# sudo git checkout unidad-1