#i will execute commands to run this script

dnf config-manager --add-repo=https://download.docker.com/linux/rhel/docker-ce.repo

dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker.service

docker --version

docker-compose --version



