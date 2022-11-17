
# CA

FROM ubuntu

RUN apt-get update && \
        apt-get install -y sudo

RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN sudo apt-get update && \
    sudo apt-get install -y easy-rsa \
                            vim


#--> Creazione della Public key infrastructure Certificate Authority (PKI CA)
RUN mkdir ~/openvpn-ca

RUN ln -s /usr/share/easy-rsa/* ~/openvpn-ca/

RUN chmod 700 /home/ubuntu/openvpn-ca/

WORKDIR /home/ubuntu/openvpn-ca

RUN ./easyrsa init-pki

COPY --chown=ubuntu:ubuntu vars vars

ENV EASYRSA_BATCH=1
RUN ./easyrsa build-ca nopass

RUN mkdir ~/keys
RUN chown ubuntu:ubuntu ~/keys
