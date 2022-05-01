#! /bin/sh

init(){
    sleep 5
    sed -i '10s|.*|        option enabled 1|' /etc/config/openvpn
    sed -i '20s|.*|        option config /configs/router1.ovpn|' /etc/config/openvpn

    service openvpn restart
    
    sleep 2
    ping -c 2 10.8.0.1 >/dev/null || echo "-----------------------\nserver is down\n-----------------------"
    ping -c 2 10.8.0.2 >/dev/null || echo "-----------------------\nclient to client is off\n-----------------------"
}

(init) &
exec /sbin/init
