
Vagrant.configure("2") do |config|
  config.vm.define :web do |web|
    web.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.name = "utn-devops-equipo2"
      vb.memory = 1024
      vb.cpus = 1
    end
    # Basado en Box de Ubuntu 18.04
    web.vm.box = "ubuntu/bionic64"
	
	#ejecutar localmente vagrant plugin install vagrant-disksize
    web.disksize.size = "10GB"
    web.vm.hostname = "web"
 
    # Forward de puertos
    web.vm.network :private_network, ip: "10.0.0.14"
    web.vm.network "forwarded_port", guest: 8080, host: 8080
    # Carpeta compartida
    web.vm.synced_folder ".", "/vagrant"

    # Timeout del boot
    config.vm.boot_timeout = 900

    # Archivo de aprovisionamiento
	web.vm.provision :shell, privileged: true, path: "bootstrap.sh", run: "always"

    #web.vm.provision :docker
    #web.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yml", rebuild: true, run: "always"
    end
end

