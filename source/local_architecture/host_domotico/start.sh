#! /bin/bash


sudo ip route del default
sudo ip route add default via 192.168.130.2 dev eth0


bash