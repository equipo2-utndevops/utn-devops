# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Basado en Box de Ubuntu 18.04
  config.vm.box = "ubuntu/bionic64"

  # Forward del puerto 80 al 8080 del host
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Carpeta compartida
  config.vm.synced_folder ".", "/vagrant"
    
  # VM Provider
  config.vm.provider "virtualbox" do |vb|
   vb.gui = true
   vb.name = "utn-devops-equipo2"
   vb.memory = "1024"
  end
  
  # Timeout del boot
  config.vm.boot_timeout = 900

  # Archivo de aprovisionamiento
  config.vm.provision :shell, path: "bootstrap.sh", run: "always"
    
end
