#!/usr/bin/env bash

# update
sudo apt-get update

# instala nginx
sudo apt-get install -y nginx

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

# ruta raíz del servidor web
WEB_ROOT="/var/www"
# ruta de la aplicación
APP_PATH="$WEB_ROOT/utn-devops-app"

# Se elimina el sitio configurado por defecto
sudo rm /etc/nginx/sites-enabled/default

# Se copia el archivo de configuracion del sitio
sudo cp /vagrant/config/utn-devops-app /etc/nginx/sites-enabled/utn-devops-app

# Se crea el directorio del sitio
sudo mkdir $APP_PATH

# Se clona la aplicación del repo
cd $WEB_ROOT
sudo git clone https://github.com/Fichen/utn-devops-app.git
cd $APP_PATH
sudo git checkout unidad-1

#Se reinicia el web servers
sudo service nginx restart 

