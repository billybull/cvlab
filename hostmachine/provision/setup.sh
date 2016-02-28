#!/bin/bash
echo "Provisioning host machine..."

echo "Updating yum and its sources..."
sudo yum update -y

echo "Installing epel-release..."
sudo yum install epel-release -y && yum clean all

echo "Installing Virtualbox Guest Additions..."
sudo mkdir -p /media/VirtualBoxGuestAdditions
sudo mount -t iso9660 -o loop VBoxGuestAdditions.iso /media/VirtualBoxGuestAdditions/
sudo /media/VirtualBoxGuestAdditions/VBoxLinuxAdditions.run
sudo mount -t vboxsf shared ~/host

#echo "Install virtualbox guest additions..."
#vagrant gem install vagrant-vbguest

#echo "Installing rsync..."
#sudo yum install -y rsync > /dev/null


echo  "Adding a yum repo..."
sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

echo "Installing Docker engine..."
sudo yum install -y docker-engine

echo "Starting Docker service..."
sudo systemctl start docker

echo "Checking the status of Docker..."
sudo systemctl status docker

echo "Add user docker to the same group as login user..."
sudo usermod -aG docker vagrant

echo "Ensuring Docker Daemon boots on system start..."
sudo systemctl enable docker
