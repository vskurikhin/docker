#!/bin/sh

hostname dc1.sigma.example.com
rm -f /etc/samba/smb.conf
samba-tool domain provision --realm=SIGMA.EXAMPLE.COM --domain SIGMA --server-role=dc
cp -f /root/krb5.conf /etc/krb5.conf
samba-tool user setpassword administrator
systemctl enable samba
systemctl start samba
samba-tool domain passwordsettings set --complexity=off
samba-tool forest directory_service dsheuristics 0000002 -H ldap://localhost --simple-bind-dn='administrator@SIGMA.EXAMPLE.COM'
samba-tool user create username password -use-username-as-cn --surname="name" --given-name="name" --initials=S --mail-address=username@sigma.sbrf.ru --company="Sigma"

