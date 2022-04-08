#! /bin/sh

sudo cp /home/ubuntu/scripts/server.conf /etc/openvpn/server


echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p