# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/centos-6.7"

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = "vagrant.localhost"
  config.hostsupdater.aliases = ["vagrant.public", "vagrant.fuel"]

  config.vm.synced_folder "./common", "/var/www/html", :mount_options => ["dmode=777,fmode=777"]

  config.vm.provider "virtualbox" do |vm|
    # メモリを1024MBに設定
    vm.memory = 1024
  end

  config.omnibus.chef_version = :latest # omnibusのプラグインを使用する
  config.vm.provision :chef_solo do |chef|
  chef.log_level = "debug"

  chef.cookbooks_path = "./cookbooks"
    chef.add_recipe "lamp"
  end

end
