#install docker

dnf config-manager --add-repo=https://download.docker.com/linux/rhel/docker-ce.repo

dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker.service

curl -L "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose

chmod +x /usr/bin/docker-compose

chown admin:docker /var/run/docker.sock

docker --version

docker-compose --version

#make samba dir on host for volume mount
mkdir -p /mnt/shareRecord
chown admin:admin /mnt/shareRecord



