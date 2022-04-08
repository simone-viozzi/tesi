
# SERVER

FROM ubuntu


RUN apt-get update && apt-get install -y sudo

RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN sudo apt-get install -y openvpn \
                            easy-rsa \
                            vim 

RUN mkdir ~/openvpn-pki

RUN ln -s /usr/share/easy-rsa/* ~/openvpn-pki/

RUN sudo chown ubuntu ~/openvpn-pki/ && \
    chmod 700 ~/openvpn-pki/

WORKDIR /home/ubuntu/openvpn-pki

COPY --chown=ubuntu:ubuntu vars vars

RUN ./easyrsa init-pki

ENV EASYRSA_BATCH=1
RUN ./easyrsa gen-req server nopass

RUN sudo cp /home/ubuntu/openvpn-pki/pki/private/server.key /etc/openvpn/server/

RUN mkdir ~/keys
RUN chown ubuntu:ubuntu ~/keys

RUN sudo apt-get install -y wget

WORKDIR /home/ubuntu

CMD [ "bash" ]