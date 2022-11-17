
# CLIENT

FROM ubuntu

RUN apt-get update && apt-get install -y sudo

RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN sudo apt-get update && \
    sudo apt-get install -y iputils-tracepath \
                            iputils-ping \
                            tcpdump \
                            iperf \
                            openvpn \
                            vim \
                            nano \
                            iproute2 \
                            net-tools

WORKDIR /home/ubuntu

COPY --chown=ubuntu:ubuntu start.sh start.sh
RUN sudo chmod +x start.sh

WORKDIR /home/ubuntu/
ENTRYPOINT [ "./start.sh" ]