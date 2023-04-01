#!/bin/bash
# 
# Script to Install and Configure Stunnel for OpenVPN
# Authors: Xaqron and RoseSecurity
# Date: 31 March, 2023

# Update and Install Stunnel
sudo apt update
sudo apt full-upgrade
sudo apt install -y stunnel4


# Create Certificates and Configuration Files
cd /etc/stunnel/
openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -sha256 -subj '/CN=127.0.0.1/O=localhost/C=US' -keyout /etc/stunnel/stunnel.pem -out /etc/stunnel/stunnel.pem
sudo touch stunnel.conf

sudo cat > /etc/stunnel/stunnel.conf << EOF
client = no
[openvpn]
accept = 443
connect = 127.0.0.1:1194
cert = /etc/stunnel/stunnel.pem
EOF

# Enable on Startup
if [ $(grep "ENABLED" /etc/default/stunnel4 > /dev/null 2&>1; echo $?) -eq 0 ]; then
    sudo sed -i -e 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
else
    sed -i '1s/^/ENABLED=1\n/' /etc/default/stunnel4
fi

# Allow 443 Traffic, Copy Pem File, and Restart Service
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo cp /etc/stunnel/stunnel.pem ~
echo -e "Configuration complete, download ~/stunnel.pem to client for further configuration"
sudo service stunnel4 restart
