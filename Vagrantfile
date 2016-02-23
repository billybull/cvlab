Vagrant.configure("2") do |config|

  config.vm.network "private_network", ip: "192.168.10.10"

  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true

  config.vm.synced_folder "./", "/var/www", create: true, group: "vagrant", owner: "vagrant"

  config.vm.provider "docker" do |v|
    d.build_dir = "."
    v.name = "Computer Vision Lab"
    v.memory = 2048
    v.cpus = 4
  end

end
