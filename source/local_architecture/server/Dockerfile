
# SERVER

FROM ubuntu AS server_1

RUN apt-get update && apt-get install -y sudo

RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN sudo apt-get update && \
    sudo apt-get install -y openvpn \
                            easy-rsa \
                            vim \
                            wget \
                            iputils-tracepath \
                            iputils-ping \
                            tcpdump \
                            iperf \
                            iptables

# <-- Configurazione della PKI di OpenVPN -->
RUN mkdir ~/openvpn-pki
RUN ln -s /usr/share/easy-rsa/* ~/openvpn-pki/
RUN sudo chown ubuntu ~/openvpn-pki/ && \
    chmod 700 ~/openvpn-pki/

WORKDIR /home/ubuntu/openvpn-pki

COPY --chown=ubuntu:ubuntu vars vars

RUN ./easyrsa init-pki

ENV EASYRSA_BATCH=1
RUN ./easyrsa gen-req server nopass batch

RUN sudo cp /home/ubuntu/openvpn-pki/pki/private/server.key /etc/openvpn/server/

RUN mkdir ~/keys
RUN chown ubuntu:ubuntu ~/keys

WORKDIR /home/ubuntu

# <-- Firma del certificato opnevpn dalla CA -->
FROM ca_base AS ca_1

COPY --from=server_1 /home/ubuntu/openvpn-pki/pki/reqs/server.req /tmp
WORKDIR /home/ubuntu/openvpn-ca

RUN ./easyrsa import-req /tmp/server.req server
RUN ./easyrsa sign-req server server

FROM server_1 AS server_2

COPY --from=ca_1 /home/ubuntu/openvpn-ca/pki/issued/server.crt /etc/openvpn/server/
COPY --from=ca_1 /home/ubuntu/openvpn-ca/pki/ca.crt /etc/openvpn/server/


# <-- Generazione della tls-crypt pre-shared key -->
WORKDIR /home/ubuntu/openvpn-pki

RUN openvpn --genkey --secret ta.key
RUN sudo cp ta.key /etc/openvpn/server

# <-- Generazione delle chiavi per i clients -->
WORKDIR /home/ubuntu/
RUN mkdir -p client-configs/keys
RUN chmod -R 700 client-configs

WORKDIR /home/ubuntu/openvpn-pki
RUN ./easyrsa gen-req client1 nopass batch
RUN ./easyrsa gen-req router1 nopass batch
RUN cp pki/private/client1.key ~/client-configs/keys/
RUN cp pki/private/router1.key ~/client-configs/keys/

FROM ca_1 AS ca_2 

COPY --from=server_2 /home/ubuntu/openvpn-pki/pki/reqs/client1.req /tmp
COPY --from=server_2 /home/ubuntu/openvpn-pki/pki/reqs/router1.req /tmp
WORKDIR /home/ubuntu/openvpn-ca
RUN ./easyrsa import-req /tmp/client1.req client1
RUN ./easyrsa sign-req client client1

RUN ./easyrsa import-req /tmp/router1.req router1
RUN ./easyrsa sign-req client router1

FROM server_2 AS server_3

COPY --from=ca_2 /home/ubuntu/openvpn-ca/pki/issued/client1.crt /home/ubuntu/client-configs/keys/
COPY --from=ca_2 /home/ubuntu/openvpn-ca/pki/issued/router1.crt /home/ubuntu/client-configs/keys/
RUN cp ~/openvpn-pki/ta.key ~/client-configs/keys/
RUN sudo cp /etc/openvpn/server/ca.crt ~/client-configs/keys/
RUN sudo chown ubuntu:ubuntu ~/client-configs/keys/*

# <-- Creazione del file di configurazione del server OpenVPN -->
COPY --chown=root:root server.conf /etc/openvpn/server/server.conf

# <-- configurazioni sulla network stack del server openvpn -->
RUN echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
#RUN sudo sysctl -p

WORKDIR /home/ubuntu/client-configs/

RUN mkdir files
COPY --chown=ubuntu:ubuntu base.conf base.conf
COPY --chown=ubuntu:ubuntu make_config.sh make_config.sh
RUN chmod 700 make_config.sh

WORKDIR /home/ubuntu

COPY --chown=ubuntu:ubuntu start.sh start.sh
RUN sudo chmod +x start.sh

WORKDIR /home/ubuntu/
ENTRYPOINT [ "./start.sh" ]