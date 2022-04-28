#! /bin/sh

init(){
sleep 7

service network stop
service network start
service network reload

#default via 192.168.0.1 dev eth0 
#10.0.4.0/24 dev eth1 proto kernel scope link src 10.0.4.4 
#192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2


}

#(init) &
exec /sbin/init

ash