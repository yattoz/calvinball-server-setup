# note: Vagrant 2.3.5 is buggy on Windows and lib/vagrant/util/file_mutex.rb must be replaced, as per this commit: 
# https://github.com/hashicorp/vagrant/pull/13159/commits/1f26256680a5bc4c78a8e14187aa8a0b926119be

# alternatively, instead of patching by hand, you may be able to get this fix with the nightly build that followed:
# https://github.com/hashicorp/vagrant/releases/tag/2.3.6.dev%2B68b3d94
# Installer for Windows: https://github.com/hashicorp/vagrant/releases/download/2.3.6.dev%2B68b3d94/vagrant_2.3.6.dev_windows_amd64.msi

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian11"
  config.vm.provider "hyperv"
  config.vm.network "public_network"

  # config.vm.provision "shell", inline: ""
  config.vm.provision "file", source: "id_rsa", destination: "id_rsa"
  config.vm.provision "file", source: "id_rsa.pub", destination: "id_rsa.pub"


  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "~/playbook.yml"
  end

end