#!/bin/sh

sudo apt upfate
sudo apt full-upgrade
sudo apt install -y stunnel4
sudo cd /etc/stunnel/
openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -sha256 -subj '/CN=127.0.0.1/O=localhost/C=US' -keyout /etc/stunnel/stunnel.pem -out /etc/stunnel/stunnel.pem
sudo echo "client = no" >> /etc/stunnel/stunnel.conf
sudo echo "[openvpn]" >> /etc/stunnel/stunnel.conf
sudo echo "accept = 443" >> /etc/stunnel/stunnel.conf
sudo echo "connect = 127.0.0.1:1194" >> /etc/stunnel/stunnel.conf
sudo echo "cert = /etc/stunnel/stunnel.pem" >> /etc/stunnel/stunnel.conf

sudo echo "ENABLED=1" >> /etc/default/stunnel4
sudo echo 'FILES="/etc/stunnel/*.conf"' >> /etc/default/stunnel4
sudo echo 'OPTIONS=""' >> /etc/default/stunnel4
sudo echo "PPP_RESTART=0" >> /etc/default/stunnel4
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
service stunnel4 restart
sudo cp /etc/stunnel/stunnel.pem ~
