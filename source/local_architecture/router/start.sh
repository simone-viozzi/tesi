#! /bin/sh

init(){
    #sleep 10
    #openvpn --config /configs/router1.ovpn &
    
    sleep 10
    ping -c 2 10.8.0.1
}

#(init) &
exec /sbin/init
