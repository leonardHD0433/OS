FROM alpine:latest

RUN apk add --no-cache \
    samba \
    samba-client \
    samba-common-tools

ENV SMB_USER=samba_admin \
    SMB_PASS=SambalisSpicy \
    SMB_GROUP=smbgroup_clinic \
    SMB_SHARE=shareRecord \
    SMB_DIR=/mnt/shareRecord

COPY ./config/smb.conf /etc/samba/smb.conf
COPY ./init/samba_user.sh /usr/local/bin/samba_user.sh

RUN chmod +x /usr/local/bin/samba_user.sh

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["/bin/sh", "-c", "/usr/local/bin/samba_user.sh && sleep infinity"]