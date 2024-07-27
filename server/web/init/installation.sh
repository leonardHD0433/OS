#!/bin/bash

dnf install -y httpd php-mysqlnd
dnf clean all
systemctl enable httpd