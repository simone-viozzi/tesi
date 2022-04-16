#! /bin/sh

sudo iptables -I INPUT -p udp -m udp --dport 1194 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 10.0.4.0/24 -o eth0@if151 -j MASQUERADE
sudo iptables --policy FORWARD ACCEPT

cd /etc/openvpn/server
sudo openvpn --status ./openvpn-server/status.log --status-version 2 --suppress-timestamps --config /etc/openvpn/server/server.conf