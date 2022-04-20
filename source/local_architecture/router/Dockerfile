
FROM openwrtorg/rootfs

RUN mkdir -p /var/lock

RUN opkg update && \
      opkg install luci \
                  wpad-wolfssl \
                  iw-full \
                  ip-full \
                  kmod-mac80211

CMD [ "sh" ]