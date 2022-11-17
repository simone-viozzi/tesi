#! /bin/sh

sleep 1.5

sudo openvpn --config /home/ubuntu/configs/client1.ovpn &

sleep 5

ping -c 2 10.8.0.1 >/dev/null && echo "-----------------------\nserver is OK\n-----------------------"|| echo "-----------------------\nserver is down\n-----------------------"
ping -c 2 10.8.0.254 >/dev/null && echo "-----------------------\nclient to client is OK\n-----------------------"|| echo "-----------------------\nclient to client is off\n-----------------------"

bash