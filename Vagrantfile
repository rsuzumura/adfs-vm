Vagrant.configure("2") do |config|
  config.vm.define "adfs-vm", autostart: false do |cfg|
    cfg.vm.box = "StefanScherer/windows_2019"
    cfg.vm.hostname = "adfs-vm"

    cfg.vm.communicator = "winrm"
    cfg.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
    cfg.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true
    cfg.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    cfg.vm.network :private_network, ip: "192.168.56.2"

    cfg.vm.provision "shell", path: "scripts/install-iis.ps1", privileged: false
    cfg.vm.provision "shell", path: "scripts/install-chocolatey.ps1", privileged: false
    cfg.vm.provision "reload"
    cfg.vm.provision "shell", path: "scripts/install-chocolatey.ps1", privileged: false
    cfg.vm.provision "shell", path: "scripts/setup-certificate.ps1", privileged: false
    cfg.vm.provision "shell", path: "scripts/install-ad.ps1", privileged: false
    cfg.vm.provision "shell", path: "scripts/set-administrador-password.ps1", privileged: false

    cfg.vm.provider "virtualbox" do |vb, override|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", 1024]
      vb.customize ["modifyvm", :id, "--cpus", 1]
      vb.customize ["modifyvm", :id, "--vram", "32"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
    end
  end
end
