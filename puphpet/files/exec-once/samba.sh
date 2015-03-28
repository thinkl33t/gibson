#!/bin/bash
sudo apt-get -t wheezy-backports install -y samba ldb-tools ldap-utils
sudo rm /etc/samba/smb.conf
sudo samba-tool domain provision --use-rfc2307 --realm hackspace.internal --domain hackspace --server-role=dc --dns-backend=SAMBA_INTERNAL
sudo samba-tool user setpassword administrator --newpassword="Password4LDAP"
sudo ldbadd -H /var/lib/samba/private/sam.ldb /vagrant/ldap/rfidCode.ldif --option="dsdb:schema update allowed"=true
sudo ldbmodify -H /var/lib/samba/private/sam.ldb /vagrant/ldap/modUser.ldif --option="dsdb:schema update allowed"=true
sudo /etc/init.d/samba restart

# rebuild ldap.conf, setting up LDAPs by default
echo "BASE dc=hackspace,dc=internal" | sudo tee /etc/ldap/ldap.conf
echo "URI ldaps://localhost:636" | sudo tee -a /etc/ldap/ldap.conf
echo "TLS_CACERT /etc/ssl/certs/ca-certificates.crt" | sudo tee -a /etc/ldap/ldap.conf
echo "TLS_REQCERT never" | sudo tee -a /etc/ldap/ldap.conf

# create a test user, and reset their password to Password4LDAP
sudo ldapadd -w Password4LDAP -D 'administrator@hackspace.internal' -f /vagrant/ldap/createUser.ldif -c
sudo samba-tool user setpassword demouser --newpassword="Password4LDAP"
