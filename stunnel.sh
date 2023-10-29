#!/bin/sh

sudo apt update
sudo apt full-upgrade
sudo apt install -y stunnel4
cd /etc/stunnel/
sudo openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -sha256 -subj '/CN=127.0.0.1/O=localhost/C=US' -keyout /etc/stunnel/stunnel.pem -out /etc/stunnel/stunnel.pem
sudo touch stunnel.conf
echo "client = no" | sudo tee -a /etc/stunnel/stunnel.conf
echo "[openvpn]" | sudo tee -a /etc/stunnel/stunnel.conf
echo "accept = 443" | sudo tee -a /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:1194" | sudo tee -a /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem" | sudo tee -a /etc/stunnel/stunnel.conf

sudo sed -i -e 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo cp /etc/stunnel/stunnel.pem ~
# download stunnel.pem from home directory. It is needed by client.
sudo service stunnel4 restart
