#i will execute commands to run this script

dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

dnf install docker-ce docker-ce-cli containerd.io -y

pip3 install docker-compose

systemctl enable docker

systemctl start docker
