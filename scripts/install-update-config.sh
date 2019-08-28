#!/bin/sh -eux
# update os
yum -y update;

# install docker
yum -y install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io

# create yva user? it can used as alternative to kickstart configuration
#sudo useradd -G wheel -m yva
#echo Default | sudo passwd --stdin yva

# configure docker
systemctl enable docker

mkdir -p /etc/docker

cat > /etc/docker/daemon.json << _EOF_
{
    "data-root": "/srv/data/docker"
}
_EOF_

reboot;
sleep 60;
