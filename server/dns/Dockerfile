# Use the ubuntu/bind9 base image
# Use the ubuntu/bind9 base image
FROM ubuntu/bind9:latest

# Copy configuration files
COPY ./config/named.conf /etc/bind/named.conf
COPY ./config/pwe69.com.lan /var/cache/bind/pwe69.com.lan
COPY ./config/0.168.192.db /var/cache/bind/0.168.192.db
COPY ./config/1.168.192.db /var/cache/bind/1.168.192.db
COPY ./config/resolv.conf /etc/resolv.conf

# Expose DNS ports
EXPOSE 53/tcp 53/udp

# Start the BIND service
CMD ["named", "-g", "-c", "/etc/bind/named.conf"]

