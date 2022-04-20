
FROM openwrtorg/rootfs

RUN mkdir -p /var/lock

RUN opkg update && \
      opkg install luci
RUN opkg update && \
      opkg install wpad-wolfssl 
RUN opkg update && \
      opkg install iw-full 
RUN opkg update && \
      opkg install ip-full 
RUN opkg update && \
      opkg install kmod-mac80211 
RUN opkg update && \
      opkg install bash



CMD [ "bash" ]