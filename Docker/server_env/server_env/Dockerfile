FROM rockylinux/rockylinux:9.4


# Install packages in one layer to reduce image size
RUN dnf -y update && \
    dnf -y install iproute net-tools traceroute bind-utils \
    procps-ng nano grep sed tar unzip zip git dnf-plugins-core python3-pip && \
    dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf -y install docker-ce docker-ce-cli containerd.io && \
    pip3 install docker-compose && \
    dnf clean all

# Set the working directory to /workspace
WORKDIR /workspace

#Git clone the docker-compose repo to the container
RUN git clone https://github.com/leonardHD0433/OS.git .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["/bin/bash"]

