#i will execute commands to run this script

dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo dnf install -y python3-pip
dnf install docker-ce docker-ce-cli containerd.io -y

dnf install -y python3-pip

pip3 --version

pip3 install docker-compose

systemctl enable docker

systemctl start docker
