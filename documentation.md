# OS Assignment

## Documentation of setting up a linux server

- [OS Assignment](#os-assignment)
  - [Documentation of setting up a linux server](#documentation-of-setting-up-a-linux-server)
    - [Services](#services)
      - [1. Open SSH Server](#1-open-ssh-server)
      - [2. Web Server](#2-web-server)
      - [3. Database Server](#3-database-server)
      - [4. File Sharing Server](#4-file-sharing-server)
      - [5. Email Server](#5-email-server)
      - [6. Security](#6-security)
      - [7. Patient Record Automated Generator](#7-patient-record-automated-generator)
    - [Issues](#issues)
  - [Note](#note)

---

### Services

---

#### 1. Open SSH Server

---

Reference : [OpenSSH Server Installation](https://reintech.io/blog/setting-up-secure-openssh-server-rocky-linux-9)   
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp; [Fail2Ban Installation](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-rocky-linux-9)

**Installing** :

    sudo dnf install -y openssh-server

    sudo systemctl enable sshd

**Configuration** :

1. **SSHD** is SSH server process, so we will configure that file

   - creating backup file

            sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

   - edit sshd_config and change port number and ssh permissions

            Port 2024

            PermitRootLogin no

2. Configuring firewall

   - Adding port 2024
  
          sudo firewall-cmd --permanent --add-port=2222/tcp  

          sudo firewall-cmd --reload

3. Reload SSH

        sudo systemctl reload sshd

4. Installing **fail2ban** for giving SSH security such as prevent multiple failed logins

     - fail2ban is third-party not default, so need to install third-party package manager **EPEL**.
  
            sudo dnf install epel-release -y

            sudo dnf install -y fail2ban

            sudo systemctl enable --now fail2ban

     - Create a local configuration file to override the defaults.

            sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

            sudo nano /etc/fail2ban/jail.local

     - Maximum retry of SSH will be 5.

5. Extra login with Key-Pair Authentication

            //generate private and public key 
            ssh-keygen -t rsa -b 4096 -C "leonardsocials@gmail.com"

            cat /home/leonardhd/.ssh/id_rsa.pub >> /home/leonardhd/.ssh/authorized_keys

            //transfer id_rsa to your client's Users\YourUsername\.ssh directory

            sudo nano /etc/ssh/sshd_config

            PubkeyAuthentication yes

            AuthorizedKeysFile      .ssh/authorized_keys

            //exit config file

            sudo systemctl reload sshd

      **Connect with Windows (Example)**

            ssh -i C:\Users\YourUsername\.ssh\id_rsa username@server_ip

---

#### 2. Web Server

---

Reference : [Server World](https://www.server-world.info/en/note?os=Rocky_Linux_8&p=httpd&f=1)

**Installing** :

      sudo dnf install httpd
      
      Is this ok [y/N]: y //confirm installation

**Configuration**:

1. Remove welcome page

       sudo rm /etc/httpd/conf.d/welcome.conf /etc httpd/conf.d/welcome.conf.org

2. Configure httpd

       sudo vi /etc/httpd/conf/httpd.conf

       //Line 89: Change to own email address
       ServerAdmin root@pwe69

       //Line 98: Change to own server name
       ServerName www.pwe69:80

       //Line 147: Allows web server to follow symbollic links
       Options FollowSymLinks

       //Line 154: Allow all directives to override server global settings
       AllowOverride All

       //Line 167: Add file name that it can access only with directory's name
       DirectoryIndex index.html index.php index.cgi

       //Add: Only return Apache in server header
       ServerTokens Prod

3. Enable service

       sudo systemctl enable --now httpd

4. Configure firewall

       sudo firewall-cmd --add-service=http

       sudo firewall-cmd --runtime-to-permanent    

**Blog System: WordPress**:

1. Install PHP

       sudo dnf module list php 
       //View list of available PHP versions

       sudo dnf module reset php //reset PHP version

       Is this ok [y/N]: y //Confirm reset

       sudo dnf module enable php:8.2 
       //switch to latest PHP version

       Is this ok [y/N]: y //Confirm switch

       //Install latest PHP version (8.2)
       sudo dnf module install php:8.2/common

       Is this ok [y/N]: y //Confirm installation

2. Restart and view httpd status

       sudo systemctl restart httpd

       sudo systemctl status php-fpm

       sudo echo '<?php phpinfo(); ?>' > /var/www/html/info.php
       //Create PHP info test page
       //This may not work because "sudo" is only applied before ">", thus system shows "Permission Denied"

       "Image of phpinfo()"

3. Install MariaDB

       Refer to Database Server

4. Install other required PHP modules

       sudo dnf --enablerepo=epel -y install php-pear php-mbstring php-pdo php-gd php-mysqlnd php-IDNA_Convert php-enchant enchant hunspell

       sudo vi /etc/php-fpm.d/www.conf //Configure the PHP file

       //Add configurations at the end of the file
       php_value[max_execution_time] = 600
       php_value[memory_limit] = 2G
       php_value[post_max_size] = 2G
       php_value[upload_max_filesize] = 2G
       php_value[max_input_time] = 600
       php_value[max_input_vars] = 2000
       php_value[date.timezone] = Asia/Kuala_Lumpur

       sudo systemctl restart php-fpm

5. Create a user and database on MariaDB for WordPress

       mariadb -u root -p
       Enter password: **********

       MariaDB [(none)]> create database wordpress;

       MariaDB [(none)]> grant all privileges on wordpress.* to wordpress@'localhost' identified by 'password'; 

       MariaDB [(none)]> flush privileges; 

       MariaDB [(none)]> exit 

6. Configure Apache httpd for WordPress

       sudo curl -O https://wordpress.org/latest.tar.gz

       sudo tar zxvf latest.tar.gz -C /var/www/

       sudo chown -R apache. /var/www/wordpress

       sudo vi /etc/httpd/conf.d/wordpress.conf //Configure wordpress.conf file

       //Add to wordpress.conf file
       Timeout 600
       ProxyTimeout 600

       Alias /wordpress "/var/www/wordpress/"
       <Directory "/var/www/wordpress">
            Options FollowSymLinks
            AllowOverride All
            Require all granted
       </Directory>

       sudo systemctl restart httpd

7. Allow policies if SELinux is enabled (SELinux enabled by default in Rocky Linux 9)

       sudo setsebool -P httpd_can_network_connect on
       
       sudo setsebool -P domain_can_mmap_files on

       sudo setsebool -P httpd_unified on

8. Access to the URL with web browser(https://[Server's Hostname or IP Address]/wordpress/)

       //Newer versions of WordPress runs the installation and configuration automatically

       //Set blog site title and administrative user account for WordPress
       Attach image of welcome page

       //Login with administrative user
       Attach image of login page

       //WordPress management site
       Attach image of management site

       //WordPress blog homepage
       Attach image of Blog
---

#### 3. Database Server

---

Reference : [Database Server Installation](https://docs.rockylinux.org/guides/database/database_mariadb-server/)

[Add User](https://docs.rockylinux.org/guides/database/database_mariadb-server/)

**Installing** :

      sudo dnf install mariadb-server

      sudo systemctl enable mariadb

      sudo systemctl start mariadb

**Configuration**:

1. Run installation (If got problem with password, refer to **Issue 2**)

       mariadb-secure-installation

       Remove anonymous users? [Y/n] Y  //to know who's loggin in

       Disallow root login remotely? [Y/n] Y  //disable remote root

       Remove test database and access to it? [Y/n] Y

       Reload privilege tables now? [Y/n] Y

       mariadb -u root -pYourPassword   //log in

2. Add simple database

       CREATE DATABASE newDB;

       SHOW DATABASES;    //display your databases

3. Add user

       CREATE USER 'username'@localhost IDENTIFIED BY 'password';

---

#### 4. File Sharing Server

---

Reference :

**Installing** :

      sudo dnf install samba

**Configuration**:

   1. Create secure access of samba

            sudo groupadd smbgroupClinic              //new permission group

            sudo mkdir /home/shareRecord              //dir for file share

            sudo chmod 770 /home/shareRecord/         //only ppl in group can access

            sudo nano /etc/samba/smb.conf             //edit config file

   2. Samba Config File

            [global]
                  unix charset = UTF-8       //filename consistency

                  hosts allow = ALL   //any ip can access with authentication

            //added at end of config file
            [shareRecord]
                  path = /home/shareRecord
                  browsable = yes
                  read only = no
                  writable = yes
                  guest ok = no
                  valid users = @smbgroupClinic
                  force group = smbgroupClinic
                  inherit permissions = yes

   3. Enable Samba

            sudo systemctl enable --now smb

            //allow samba service through firewall
            sudo firewall-cmd --permanent --add-service=samba 

            //add samba user
            sudo useradd -m sambaAdmin
            sudo smbpasswd -a username    

            sudo usermod -aG smbgroupClinic sambaAdmin

---

#### 5. Email Server

#### 6. Security

#### 7. Patient Record Automated Generator

---

Reference:

**Installing**:

      sudo dnf install python3-pip        //useful for downloading packages

**Configuration**:

      sudo mkdir /home/recordGen          //where python file resides

### Issues

1. **Open SSH server**

     - Issue with SSH (solved)

        **Reason** : SELinux does not recognize non standard port 2024

        **Solution** :

              sudo semanage port -a -t ssh_port_t -p tcp 2024

              sudo restorecon -Rv /etc/ssh

        Reference : [Change to non standard port](https://www.techrepublic.com/article/how-to-configure-ssh-to-use-a-non-standard-port-with-selinux-set-to-enforcing/)

2. **Database Server**

      - Issue with starting installations

        **Reason** : Default root password "enter" does not work

        **Solution** :

            sudo mariadb -u root

            USE mysql;

            ALTER USER 'root'@'localhost' IDENTIFIED BY 'insert  new password here';

            FLUSH PRIVILEGES;

            exit

3. **Samba Server**

      -Issue with client can't run 'ls' command

      -Error Message: NT_STATUS_ACCESS_DENIED listing

      **Reason** : SELinux context for samba folder is wrong

      **Solution** :

            //checked shareRecord context is home_dir
            ls -Z /home  

            //For Samba shares, the context should include samba_share_t
            sudo chcon -R -t samba_share_t /home/shareRecord 

            //persistent across reboots
            sudo semanage fcontext -a -t samba_share_t "/home/shareRecord(/.*)?"
            sudo restorecon -R /home/shareRecord

            //reload policy
            sudo load_policy

## Note

- check ssh status

      systemctl status sshd

- check firewall

      sudo firewall-cmd --list-all

- check fail2ban status

      systemctl status fail2ban

- check mariadb status

      systemctl status mariadb

- check samba status

      systemctl status smb

- check all user in database

      SELECT User FROM mysql.user;

- show all databases

      SHOW DATABASES;

- show current user

      SELECT USER();

- check users in the group

      getent group smbgroupClinic

- check SELinux status

      getenforce

- check what port services are listening on

      sudo ss -tnlp | grep sevice_name