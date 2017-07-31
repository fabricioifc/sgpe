# -*- mode: ruby -*-
# vi: set ft=ruby :

# ip da máquina virtual
$ip_vm = "192.168.33.10"

Vagrant.configure("2") do |config|
  config.env.enable #necessário para acessar as variáveis de ambiente
#  config.vm.box = "ubuntu/trusty64"
#  config.vm.box_version = "20170619.0.0"
   config.vm.box = "ubuntu/xenial64"
   config.vm.box_version = "20170717.0.0"

  config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
  SHELL

  # --- variáveis de ambiente ---
  config.vm.provision "shell", inline: <<-SHELL
    echo -n                                                             >  /etc/profile.d/variaveis_projeto.sh
    echo "export POSTGRES_DEV_HOST=#{ENV['POSTGRES_DEV_HOST']}"         >> /etc/profile.d/variaveis_projeto.sh
    echo "export POSTGRES_DEV_PASSWORD=#{ENV['POSTGRES_DEV_PASSWORD']}" >> /etc/profile.d/variaveis_projeto.sh
    echo "export POSTGRES_PRD_HOST=#{ENV['POSTGRES_PRD_HOST']}"         >> /etc/profile.d/variaveis_projeto.sh
    echo "export POSTGRES_PRD_PASSWORD=#{ENV['POSTGRES_PRD_PASSWORD']}" >> /etc/profile.d/variaveis_projeto.sh
  SHELL

  # install rvm and ruby
  ruby_version = File.read(File.expand_path(".ruby-version", __dir__)).to_s.chomp
  config.vm.provision "shell", privileged: false, path: "vagrant/install_rvm.sh", args: "stable"
  config.vm.provision "shell", privileged: false, path: "vagrant/install_ruby.sh", args: ruby_version

  # this is required if you wish to use NFS under VirtualBox
  # @see section Prerequisites in https://www.vagrantup.com/docs/synced-folders/nfs.html
 config.vm.network "private_network", ip: $ip_vm
#  config.vm.network "private_network", type: "dhcp"
  # make sure that the port Rails uses is forwarded to VM
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  # current working folder basename
  base_name = `basename $(pwd)`
 config.vm.provision "shell", privileged: false, path: "vagrant/setup.sh",
     args: [base_name, "#{ENV['GIT_NAME']}", "#{ENV['GIT_EMAIL']}"]
end
