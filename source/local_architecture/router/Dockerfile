
FROM openwrtorg/rootfs

RUN mkdir -p /var/run \
 && mkdir -p /var/lock

RUN opkg remove --force-depends \
      dnsmasq* \
      wpad* \
      iw*

RUN opkg update && \
      opkg install luci
RUN opkg update && \
      opkg install iw-full 
RUN opkg update && \
      opkg install wpad-wolfssl 
RUN opkg update && \
      opkg install ip-full 
RUN opkg update && \
      opkg install kmod-mac80211
RUN opkg update && \
      opkg install openvpn
RUN opkg update && \
      opkg install dnsmasq-full
RUN opkg update && \
      opkg install iptables-mod-checksum
RUN opkg update && \
      opkg install tcpdump
RUN opkg update && \
      opkg install vim-fuller

RUN opkg list-upgradable | awk '{print $1}' | xargs opkg upgrade || true


COPY config/* /etc/config/

RUN echo "iptables -A POSTROUTING -t mangle -p udp --dport 68 -j CHECKSUM --checksum-fill" >> /etc/firewall.user



COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT [ "./start.sh" ]