#! /bin/sh

sudo cp /home/ubuntu/keys/server.crt /etc/openvpn/server
sudo cp /home/ubuntu/keys/ca.crt /etc/openvpn/server


cd ~/openvpn-pki/
openvpn --genkey --secret ta.key
sudo cp ta.key /etc/openvpn/server

sudo apt-get install -y wget