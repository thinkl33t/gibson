#!/bin/bash
sudo apt-get -t wheezy-backports install -y samba ldb-tools ldap-utils
sudo rm /etc/samba/smb.conf
sudo samba-tool domain provision --use-rfc2307 --realm hackspace.internal --domain hackspace --server-role=dc --dns-backend=SAMBA_INTERNAL
sudo samba-tool domain passwordsettings set --complexity=off
sudo samba-tool user setpassword administrator --newpassword="password"
sudo ldbadd -H /var/lib/samba/private/sam.ldb /vagrant/ldap/rfidCode.ldif --option="dsdb:schema update allowed"=true
sudo ldbmodify -H /var/lib/samba/private/sam.ldb /vagrant/ldap/modUser.ldif --option="dsdb:schema update allowed"=true