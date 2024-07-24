FROM rockylinux/rockylinux:9.4

# Install basic troubleshooting tools
RUN dnf -y install iproute net-tools traceroute bind-utils \
    procps-ng nano grep sed awk tar unzip zip git && \
    dnf clean all

#Install Docker
RUN dnf -y update && \
    dnf -y install dnf-plugins-core && \
    dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo && \
    dnf -y install docker-ce docker-ce-cli containerd.io && \
    dnf clean all

#Install Docker Compose
RUN dnf -y install python3-pip && \
    pip3 install docker-compose

#Enable and start Docker
RUN systemctl enable docker && systemctl start docker

#Copy the /server to the container
COPY /server /workspace

CMD ["/bin/bash"]

