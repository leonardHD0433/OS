# Use the ubuntu/bind9 base image
FROM rockylinux:9

# Update and install necessary packages
RUN dnf -y update && dnf -y install \
    bind \
    bind-utils \
    && dnf clean all

# Set permissions
RUN mkdir -p /var/named && \
    chown -R named:named /var/named && \
    chmod 755 /var/named

# Copy configuration files
COPY ./config/named.conf /etc/named.conf
COPY ./config/pwe69.com.lan /var/named/pwe69.com.lan
COPY ./config/0.168.192.db /var/named/0.168.192.db
COPY ./config/resolv.conf /etc/resolv.conf

RUN chown named:named /etc/named.conf /var/named/pwe69.com.lan /var/named/0.168.192.db && \
    chmod 644 /etc/named.conf /var/named/pwe69.com.lan /var/named/0.168.192.db

# Expose DNS ports
EXPOSE 53/tcp 53/udp

# Start the BIND service
CMD ["named", "-g", "-c", "/etc/named.conf"]

