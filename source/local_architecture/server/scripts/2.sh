#! /bin/sh


mkdir -p ~/client-configs/keys
chmod -R 700 ~/client-configs


cp /home/ubuntu/keys/client1.crt ~/client-configs/keys/
cp ~/openvpn-pki/ta.key ~/client-configs/keys/
sudo cp /etc/openvpn/server/ca.crt ~/client-configs/keys/
sudo chown ubuntu:ubuntu ~/client-configs/keys/*