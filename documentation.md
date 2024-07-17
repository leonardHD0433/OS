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

---

#### 2. Web Server

---

Reference : [Web Server Installation](https://reintech.io/blog/setting-up-secure-openssh-server-rocky-linux-9)

**Installing** :

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

**Configuration**

   1. Create secure access of samba

            sudo groupadd smbgroupClinic

            sudo mkdir /home/shareRecord


#### 5. Email Server

#### 6. Security

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

## Note

- check ssh status

      systemctl status sshd

- check firewall

      sudo firewall-cmd --list-all

- check fail2ban status

      systemctl status fail2ban

- check mariadb status

      systemctl status mariadb

- check all user in database

      SELECT User FROM mysql.user;

- show all databases

      SHOW DATABASES;

- show current user

      SELECT USER();
