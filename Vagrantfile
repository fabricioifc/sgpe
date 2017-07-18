# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_version = "20170113.0.0"

  config.ssh.forward_agent = true

    config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
  SHELL

  # install rvm and ruby
  ruby_version = File.read(File.expand_path(".ruby-version", __dir__)).to_s.chomp
  config.vm.provision "shell", privileged: false, path: "vagrant/install_rvm.sh", args: "stable"
  config.vm.provision "shell", privileged: false, path: "vagrant/install_ruby.sh", args: ruby_version

    # this is required if you wish to use NFS under VirtualBox
    # @see section Prerequisites in https://www.vagrantup.com/docs/synced-folders/nfs.html
    config.vm.network "private_network", ip: "192.168.33.10"
  # make sure that the port Rails uses is forwarded to VM
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  # current working folder basename
  base_name = `basename $(pwd)`
  config.vm.provision "shell", privileged: false, path: "vagrant/setup.sh", args: base_name
end
