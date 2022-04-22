#! /bin/sh

sleep 1.5

sudo openvpn --config /home/ubuntu/configs/client1.ovpn &

ping -c 2 10.8.0.1

bash