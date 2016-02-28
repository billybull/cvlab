Vagrant.configure("2") do |config|

  config.vm.network "private_network", ip: "192.168.10.10"

  config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct: true

  config.vm.synced_folder "./", "/var/www", create: true
  #config.vm.provision "docker",
    #images: ["Host Machine"]

  config.vm.provider "docker" do |d|
    d.vagrant_vagrantfile = "./hostmachine/Vagrantfile"
    d.build_dir = "."
    d.name = "Computer_Vision_Lab"
    d.remains_running = true
    #d.has_ssh = true
    #d.ports = ["8080:8080"]
    #d.memory = 2048
    #d.cpus = 4
  end


end
