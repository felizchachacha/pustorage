#!/bin/sh

# https://www.neilgrogan.com/vagrant-ubuntu-fossa/

set -xe

# mkdir ubuntu ubuntu/http ubuntu/output ubuntu/scripts
# cd ubuntu

cat > http/user-data << 'EOF'
#cloud-config
autoinstall:
    version: 1
    locale: en_US
    keyboard:
      layout: en
      variant: uk
    identity:
      hostname: vagrant
      password: '$2y$12$zfS.Dpm682guriw6fJ5PXu4Kv7GSs7VYHUPGphQdSnT0wb4Rt1tVS'
      username: vagrant
    ssh:
      install-server: true
EOF

touch http/meta-data

cat > scripts/init.sh << 'EOF'
#!/bin/bash

sudo apt update
sudo apt upgrade -y
EOF

{% raw %}
cat > ubuntu2004.json << 'EOF'
{
    "builders": [
      {
        "name": "ubuntu-2004",
        "type": "virtualbox-iso",
        "guest_os_type": "ubuntu-64",
        "headless": false,

        "iso_url": "http://releases.ubuntu.com/20.04/ubuntu-20.04-live-server-amd64.iso",
        "iso_checksum": "caf3fd69c77c439f162e2ba6040e9c320c4ff0d69aad1340a514319a9264df9f",
        "iso_checksum_type": "sha256",

        "ssh_username": "vagrant",
        "ssh_password": "vagrant",
        "ssh_handshake_attempts": "20",

        "http_directory": "http",
        "memory": 1024,

        "boot_wait": "5s",
        "boot_command": [
          "<enter><enter><f6><esc><wait> ",
          "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
          "<enter>"
        ],
        "shutdown_command": "echo 'vagrant'|sudo -S shutdown -P now",
        "guest_additions_path": "VBoxGuestAdditions_{{.Version}}.iso",
        "virtualbox_version_file": ".vbox_version",
        "vm_name": "packer-ubuntu-20.04-amd64",
        "vboxmanage": [
        [
            "modifyvm",
            "{{.Name}}",
            "--memory",
            "1024"
        ],
        [
            "modifyvm",
            "{{.Name}}",
            "--cpus",
            "1"
        ]
        ]
      }
    ],
    "provisioners": [
        {
            "type": "shell",
            "script": "scripts/init.sh",
            "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
        },
        {
            "type": "shell",
            "script": "scripts/cleanup.sh",
            "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
        }
    ],
    "post-processors": [{
      "type": "vagrant",
      "compression_level": "8",
      "output": "output/ubuntu-20.04.box"
    }]
  }

EOF
{% endraw %}

packer build ubuntu2004.json

vagrant box add --name ubuntu20.04 output/ubuntu-20.04.box

cat > Vagrantfile << 'EOF'
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu20.04"
  config.ssh.password = "vagrant"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  end
end

EOF

vagrant up && vagrant ssh

