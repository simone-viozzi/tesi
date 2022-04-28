FROM openwrtorg/rootfs

RUN mkdir /var/lock && \
    touch /var/lock/opkg.lock && \
    opkg update && \
    opkg install curl \
                 jq \
                 luci \
                 luci-ssl