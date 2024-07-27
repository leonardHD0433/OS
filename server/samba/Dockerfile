FROM rockylinux/rockylinux:9.4

RUN dnf install -y \
    samba \
    samba-client \
    samba-common-tools && \
    dnf clean all

ENV SMB_USER=samba_admin \
    SMB_PASS=SambalisSpicy \
    SMB_GROUP=smbgroup_clinic \
    SMB_SHARE=shareRecord \
    SMB_DIR=/mnt/shareRecord

COPY ./config/smb.conf /etc/samba/smb.conf
COPY ./init/samba_user.sh /usr/local/bin/samba_user.sh
COPY ./init/samba_up.sh /usr/local/bin/samba_up.sh

RUN chmod +x /usr/local/bin/samba_user.sh /usr/local/bin/samba_up.sh

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/samba_user.sh && /usr/local/bin/samba_up.sh && sleep infinity"]