# note: Vagrant 2.3.5 is buggy on Windows and lib/vagrant/util/file_mutex.rb must be replaced, as per this commit: 
# https://github.com/hashicorp/vagrant/pull/13159/commits/1f26256680a5bc4c78a8e14187aa8a0b926119be

# alternatively, instead of patching by hand, you may be able to get this fix with the nightly build that followed:
# https://github.com/hashicorp/vagrant/releases/tag/2.3.6.dev%2B68b3d94
# Installer for Windows: https://github.com/hashicorp/vagrant/releases/download/2.3.6.dev%2B68b3d94/vagrant_2.3.6.dev_windows_amd64.msi

# NOTE THAT HYPER-V DOESNT ALLOW NETWORK COMMANDS, HENCE NO PORT FORWARDING
# This vagrantfile does not work on Windows if you use Hyper-V.


Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian11"
  # config.vm.provider "hyperv"
  config.vm.network "public_network"

  config.vm.network "forwarded_port", guest: 80, host: 8880, auto_correct: true
  config.vm.network "forwarded_port", guest: 443, host: 4444, auto_correct: true
  config.vm.network "forwarded_port", guest: 9090, host: 9990, auto_correct: true
  config.vm.network "forwarded_port", guest: 22, host: 2222, auto_correct: true


  config.vm.provision "shell", inline: "mkdir -p vars ; chown vagrant:vagrant vars"
  config.vm.provision "file", source: "id_rsa", destination: "/tmp/id_rsa"
  config.vm.provision "file", source: "id_rsa.pub", destination: "/tmp/id_rsa.pub"
  config.vm.provision "file", source: "playbook.yml", destination: "playbook.yml"
  config.vm.provision "file", source: "vars/users.yml", destination: "vars/users.yml"
  config.vm.provision "file", source: "vars/packages.yml", destination: "vars/packages.yml"

=begin
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "/home/vagrant/playbook.yml" # by default, as user, but we change the user below
    ansible.limit = "all"
    ansible.compatibility_mode = "2.0"
    ansible.verbose = "-vvv"
  end
=end


  config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y ansible"
  config.vm.provision "shell", inline: "sudo su root -c \"ansible-playbook /home/vagrant/playbook.yml -v\""

end