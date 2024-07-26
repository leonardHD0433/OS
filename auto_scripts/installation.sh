#!/bin/bash

#cd working directory
cd /workspace/ssh

#allow ports for the docker container port mapping
firewall-cmd --permanent --add-port=80/tcp    #http
firewall-cmd --permanent --add-port=443/tcp    #https
firewall-cmd --permanent --add-port=53/tcp --add-port=53/udp   #dns
firewall-cmd --permanent --add-port=25/tcp   #smtp
firewall-cmd --permanent --add-port=587/tcp    #smtp submission
firewall-cmd --permanent --add-port=465/tcp    #smtps
firewall-cmd --permanent --add-port=110/tcp    #pop3
firewall-cmd --permanent --add-port=995/tcp    #pop3s
firewall-cmd --permanent --add-port=143/tcp    #imap
firewall-cmd --permanent --add-port=993/tcp    #imaps
firewall-cmd --permanent --add-port=3306/tcp    #mysql
firewall-cmd --reload

#install docker
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io
pip3 install docker-compose
dnf clean all
systemctl enable docker
systemctl start docker





