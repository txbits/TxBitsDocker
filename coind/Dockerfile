FROM debian:wheezy

ARG COIND_GIT
ARG COIND_VERSION
ARG COIND_NAME

RUN apt-get update && \
    apt-get install -y build-essential libboost-all-dev libssl-dev libdb-dev libdb++-dev libglib2.0-dev git autoconf libtool

# TODO: combine these
# we need bsdmainutils for hexdump. otherwise litecoind refuses to build
RUN apt-get install -y bsdmainutils

RUN mkdir /data && \
    cd /root && \
    mkdir -p /root/coind && \
    git clone $COIND_GIT /root/coind -b $COIND_VERSION && \
    which hexdump && \
    cd /root/coind && \
    ./autogen.sh && \
    ./configure --with-incompatible-bdb --disable-hardening && \
    make && \
    install --mode 755 --owner=root /root/coind/src/$COIND_NAME /usr/bin/coind
# TODO: we should remove some of these terrible flags above

#TODO: move this up
RUN apt-get install -y wget

RUN cd /root && \
    wget https://www.tarsnap.com/spiped/spiped-1.4.2.tgz -O /root/spiped-1.4.2.tgz && \
    tar -zxvf /root/spiped-1.4.2.tgz && \
    cd /root/spiped-1.4.2 && \
    make && \
    install --mode=755 --owner=root /root/spiped-1.4.2/spipe/spipe /usr/bin/spipe && \
    install --mode=755 --owner=root /root/spiped-1.4.2/spiped/spiped /usr/bin/spiped

ADD templates/coind.conf /coind.conf

RUN wget https://github.com/jwilder/dockerize/releases/download/v0.0.3/dockerize-linux-amd64-v0.0.3.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.0.3.tar.gz

CMD /usr/bin/spiped -d -s 0.0.0.0:10001 -t 127.0.0.1:10000 -k /secrets/spiped_secret && \
    dockerize -template /coind.conf:/root/coind.conf /usr/bin/coind -datadir=/data -conf=/root/coind.conf -daemon=0
