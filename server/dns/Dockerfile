# Use the ubuntu/bind9 base image
FROM rockylinux:latest

# Update and install necessary packages
RUN dnf -y update && yum -y install \
    bind \
    bind-utils \
    && dnf clean all

# Copy configuration files
COPY ./config/named.conf /etc/named.conf
COPY ./config/pwe69.com.lan /etc/named/pwe69.com.lan
COPY ./config/0.168.192.db /etc/named/0.168.192.db
COPY ./config/resolv.conf /etc/resolv.conf

# Set permissions
RUN chown -R named:named /var/named

# Expose DNS ports
EXPOSE 53/tcp 53/udp

# Start the BIND service
CMD ["named", "-g", "-c", "/etc/named.conf"]

