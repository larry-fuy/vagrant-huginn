
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Latest version trusty isn't work
  config.vm.box = "hashicorp/precise64" 

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.provider :virtualbox do |override|
    override.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "2", "--ioapic", "on", "--name", "huggin"]
  end
  
  config.vm.provision :shell, :path => "bootstrap.sh"

  # forward port
  config.vm.network "forwarded_port", guest: 3000, host: 3000
end
