#! /bin/sh

init(){
    sleep 5
    sed -i '10s|.*|        option enabled 1|' /etc/config/openvpn
    sed -i '20s|.*|        option config /configs/router1.ovpn|' /etc/config/openvpn

    service openvpn restart

    tee -a /etc/config/firewall <<EOF

    
config zone
        option name 'vpn'
        option src 'lan'
        option dest 'lan'
        option input 'ACCEPT'
        option output 'ACCEPT'
        option forward 'ACCEPT'
        list network 'tun0'

config forwarding
        option src 'vpn'
        option dest 'lan'

config forwarding
        option src 'lan'
        option dest 'vpn'
EOF

    tee -a /etc/config/network <<EOF


config interface 'tun0'
        option proto 'static'
        option device 'tun0'
        option ipaddr '10.8.0.254'
        option netmask '255.255.255.0'
EOF

    service network restart
    service firewall restart

    
    sleep 2
    ping -c 2 10.8.0.1 >/dev/null || echo -e "-----------------------\nserver is down\n-----------------------"
    ping -c 2 10.8.0.2 >/dev/null || echo -e "-----------------------\nclient to client is off\n-----------------------"

}

(init) &
exec /sbin/init
