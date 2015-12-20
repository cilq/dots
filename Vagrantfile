# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  # config.vm.box = "hashicorp/precise64"
  config.vm.define "ubuntu", primary: true do |ubuntu|
    ubuntu.vm.box = "ubuntu/wily64"
    ubuntu.vm.network "forwarded_port", guest: 8080, host: 8080
    ubuntu.vm.network "forwarded_port", guest: 8443, host: 8443
    # ubuntu.vm.network "forwarded_port", guest: 3306, host: 3306
    ubuntu.vm.network "forwarded_port", guest: 2375, host: 2375
    ubuntu.vm.provider "virtualbox" do |v|
      v.memory = 2048
      # v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      # v.customize ["storageattach", :id, "--storagectl", "SATAController", "--medium", "180fbc2d-045c-409d-a803-5a4fbc09453c", "--port", "1", "--type", "hdd"]
    end
    ubuntu.vm.provision "shell", inline: <<-SHELL
      # echo "export http_proxy=http://proxy.clondiag.jena:8080 >> ~/.bashrc"
      # echo "export https_proxy=http://proxy.clondiag.jena:8080 >> ~/.bashrc"
      # echo "export ftp_proxy=http://proxy.clondiag.jena:8080 >> ~/.bashrc"
      echo "####################"
      echo "###### Docker ######"
      echo "####################"
      echo 
      echo "## Preparing repository"
      apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D >> /dev/null
      echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" > /etc/apt/sources.list.d/docker.list
      echo "## Updating Repository"
      apt-get -qq update 
      apt-get -qq purge lxc-docker*
      apt-cache policy docker-engine
      echo "## Installing packages"
      apt-get -qq install -y linux-image-extra-$(uname -r) docker-engine
      echo "## Starting up and testing"
      mkdir -p /etc/systemd/system/docker.service.d
      echo "[Service]" > /etc/systemd/system/docker.service.d/override.conf
      echo "ExecStart=" >> /etc/systemd/system/docker.service.d/override.conf
      echo "ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:2375" >> /etc/systemd/system/docker.service.d/override.conf
      service docker start
      docker run hello-world
      usermod -aG docker vagrant
      systemctl enable docker
      echo "####################"
      echo "##### Node.js ######"
      echo "####################"
      echo
      echo "## Preparing Repository" 
      curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
      echo "## Installing packages"
      sudo apt-get install -y nodejs -y build-essential
      echo "####################"
      echo "#### Web Stuff #####"
      echo "####################"
      echo
      sudo npm install -g gulp
      sudo npm install -g bower
      sudo npm install -g generator-polymer
      echo "####################"
      echo "###### Python ######"
      echo "####################"
      apt-get install -y python-pip python3-pip
      echo "####################"
      echo "###### System ######"
      echo "####################"
      apt-get install -y ncdu
      apt-get install -y runit
      echo "LABEL=docker-share      /srv     ext4   defaults        0 0" >> /etc/fstab
    SHELL
  end

  config.vm.define "gitlab" do |gitlab|
    
    gitlab.vm.provider "docker" do |d|
      d.image = "gitlab/gitlab-ce"
      d.vagrant_vagrantfile = "Vagrantfile"
      d.vagrant_machine = "ubuntu"
      d.create_args = ["--detach"]
      d.ports = ["8443:443", "8080:80", "2222:22"]
      d.name = "gitlab"
      d.has_ssh = true
      d.volumes = ["/srv/gitlab/config:/etc/gitlab", "/srv/gitlab/logs:/var/log/gitlab", "/srv/gitlab/data:/var/opt/gitlab"]
    end
  end

  config.vm.define "mariadb" do |mariadb|
    
    mariadb.vm.provider "docker" do |d|
      d.image = "bitnami/mariadb"
      d.vagrant_vagrantfile = "Vagrantfile"
      d.vagrant_machine = "ubuntu"
      d.create_args = ["--detach"]
      d.ports = ["3306:3306"]
      d.name = "mariadb"
      d.has_ssh = true
      d.env = {MARIADB_PASSWORD: "einfach"}
      d.volumes = ["/srv/mariadb/config:/bitnami/mariadb/conf", "/srv/mariadb/logs:/bitnami/mariadb/logs", "/srv/mariadb/data:/bitnami/mariadb/data"]
    end
  end

  config.vm.define "mysql" do |mysql|
    
    mysql.vm.provider "docker" do |d|
      d.image = "mysql:latest"
      d.vagrant_vagrantfile = "Vagrantfile"
      d.vagrant_machine = "ubuntu"
      d.create_args = ["--detach"]
      d.ports = ["3306:3306"]
      d.name = "mysql"
      d.has_ssh = true
      d.env = {MYSQL_ROOT_PASSWORD: "einfach"}
    end
  end

  config.vm.define "docker" do |d|
    d.vm.box = "dduportal/boot2docker"
    d.vm.network "forwarded_port", guest: 2377, host: 2377
  end

  config.vm.define "registry" do |r|
    r.vm.network "forwarded_port", guest: 5000, host: 5000
    r.vm.provider "docker" do |d|
      d.image = "registry:2"
      d.vagrant_vagrantfile = "Vagrantfile"
      d.vagrant_machine = "docker"
      d.create_args = ["--detach"]
      d.ports = ["5000:5000"]
      d.name = "registry"
      d.volumes = ["/svr/registry:/var/lib/registry"]

    end
  end

  config.vm.define "windows" do |w|
    w.vm.box = "modernIE/w10-edge"
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 8080, host: 8080
  # config.vm.network "forwarded_port", guest: 8443, host: 8443

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   echo "export HTTP_PROXY=http://proxy.clondiag.jena:8080" >> /var/lib/boot2docker/profile
  #   echo "export HTTPS_PROXY=http://proxy.clondiag.jena:8080" >> /var/lib/boot2docker/profile
  #   echo "export FTP_PROXY=http://proxy.clondiag.jena:8080" >> /var/lib/boot2docker/profile
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
end
