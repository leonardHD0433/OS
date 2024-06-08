# OS Assignment

## Documentation of setting up a linux server

- [OS Assignment](#os-assignment)
  - [Documentation of setting up a linux server](#documentation-of-setting-up-a-linux-server)
    - [Open SSH server](#open-ssh-server)
    - [Services](#services)
  - [Note](#note)

### Open SSH server

---

Reference : [OpenSSH Server Installation](https://reintech.io/blog/setting-up-secure-openssh-server-rocky-linux-9)

**Installing**

    sudo dnf install -y openssh-server

    sudo systemctl enable sshd

**Configuration**

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

### Services

---

1. **Web**
2. **Database**
3. **File Sharing**
4. **Email**
5. **Security**

## Note

- check ssh status

      sudo systemctl status sshd

- check firewall

      sudo firewall-cmd --list-all

- issue with ssh (solved)

  - Reason : SELinux does not recognize non standard port 2024

        sudo semanage port -a -t ssh_port_t -p tcp 2024

        sudo restorecon -Rv /etc/ssh
