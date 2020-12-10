#!/usr/bin/env bash

export BASE="/home/vagrant"

#ENABLE REPO NECESARY FOR PUPPET
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo apt-get update -y

#ADD PUPPET REPO
wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
sudo dpkg -i puppet6-release-bionic.deb
sudo apt-get update
rm -f puppet6-release-bionic.deb

#INSTALL PUPPET SERVER AND AGENT

sudo apt-get install -y puppetserver puppet-agent

#CONFIG PUPPETSERVER
sudo sed -i 's/JAVA_ARGS="-Xms2g -Xmx2g/JAVA_ARGS="-Xms512m -Xmx512m/g' /etc/default/puppetserver


#CONFIG CA PUPPETSERVER AND AGENT
runuser -u vagrant -c 'puppetserver ca setup --ca-name puppet --certname puppet'

#START PUPPET SERVER AND AGENT 
sudo systemctl enable puppetserver
sudo systemctl start puppetserver
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true


#COPY PUPPET FILES
cp -R /vagrant/puppet $BASE

#RUN PUPPET AND INSTALL JENKINS
sudo -E env "PATH=$PATH" /opt/puppetlabs/bin/puppet apply --modulepath $BASE/puppet/modules/ -e 'class {"jenkins":}'


