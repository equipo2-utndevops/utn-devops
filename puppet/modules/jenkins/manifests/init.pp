class jenkins {
    # get key
    exec { 'install_jenkins_key':
        command => '/usr/bin/wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -',
    }
    
    # source file
    file { '/etc/apt/sources.list.d/jenkins.list':
        content => "deb http://pkg.jenkins-ci.org/debian binary/\n",
        mode    => '0644',
        owner   => root,
        group   => root,
        require => Exec['install_jenkins_key'],
    }

    # update
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
        require => File['/etc/apt/sources.list.d/jenkins.list'],
    }

    # jenkins package
    package { 'jenkins':
        ensure  => latest,
    }

    # jenkins service
    service { 'jenkins':
        ensure  => running,
        require => Package['jenkins'],
    }
    # modify jenkins port
    exec { 'modify config file':
        command => "/bin/sed -i 's/HTTP_PORT=8080/HTTP_PORT=8082/g' /etc/default/jenkins",
    }
    
    # jenkins restart
    exec { 'jenkins service restart':
        command => "/bin/systemctl restart jenkins",
    }    
}
