
FROM openwrtorg/rootfs

RUN mkdir -p /var/lock

RUN opkg update

RUN opkg install luci \
      wpad-wolfssl \
      iw-full \
      ip-full \
      kmod-mac80211