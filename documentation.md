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

---

#### 2. Web Server

---

Reference : [Web Server Installation](https://reintech.io/blog/setting-up-secure-openssh-server-rocky-linux-9)

**Installing** :


---

#### 3. Database Server

---

---

#### 4. File Sharing Server

#### 5. Email Server

#### 6. Security

### Issues

1. **Open SSH server**

     - Issue with SSH (solved)

        **Reason** : SELinux does not recognize non standard port 2024

              sudo semanage port -a -t ssh_port_t -p tcp 2024

              sudo restorecon -Rv /etc/ssh

        Reference : [Change to non standard port](https://www.techrepublic.com/article/how-to-configure-ssh-to-use-a-non-standard-port-with-selinux-set-to-enforcing/)

2. 

## Note

- check ssh status

      sudo systemctl status sshd

- check firewall

      sudo firewall-cmd --list-all


