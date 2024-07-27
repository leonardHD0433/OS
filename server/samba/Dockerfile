FROM dperson/samba

ENV SMB_USER=sambaAdmin \
    SMB_PASS=SambalisSpicy \
    SMB_GROUP=smbgroupClinic \
    SMB_SHARE=shareRecord \
    SMB_DIR=/home/shareRecord

COPY ./config/smb.conf /etc/samba/smb.conf
COPY ./init/samba_user.sh /usr/local/bin/samba_user.sh

RUN chmod +x /usr/local/bin/samba_user.sh

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["/usr/local/bin/samba_user.sh"]
