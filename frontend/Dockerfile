FROM debian:wheezy

ADD GPG-KEY-java8 /root/GPG-KEY-java8

ENV DEBIAN_FRONTEND noninteractive
RUN apt-key add /root/GPG-KEY-java8 && \
        /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
        /bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections && \
        echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
        echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
        apt-get update && \
        apt-get install -y oracle-java8-installer git wget

WORKDIR /root

RUN git clone https://github.com/txbits/txbits.git && \
    cd txbits && \
    git checkout v0.2.0 && \
    ./txbits.sh universal:packageZipTarball && \
    mkdir /txbits && \
    tar -zxvf /root/txbits/txbits/target/universal/txbits-1.0-SNAPSHOT.tgz --directory /txbits

RUN cd /root && \
    wget https://github.com/jwilder/dockerize/releases/download/v0.0.3/dockerize-linux-amd64-v0.0.3.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.0.3.tar.gz

# TODO: move this up
RUN apt-get install -y curl libssl-dev zlib1g-dev e2fslibs-dev build-essential

RUN cd /root && \
    wget https://www.tarsnap.com/spiped/spiped-1.4.2.tgz -O /root/spiped-1.4.2.tgz && \
    tar -zxvf spiped-1.4.2.tgz && \
    cd /root/spiped-1.4.2 && \
    make && \
    install --mode=755 --owner=root /root/spiped-1.4.2/spipe/spipe /usr/bin/spipe && \
    install --mode=755 --owner=root /root/spiped-1.4.2/spiped/spiped /usr/bin/spiped

ADD logback.xml /txbits/txbits-1.0-SNAPSHOT/conf/logback.xml
ADD txbits_truststore /txbits/txbits-1.0-SNAPSHOT/truststore

CMD /usr/bin/spiped -e -s 127.0.0.1:10001 -t txbitsdocker_bitcoind_1:10001 -k /secrets/bitcoind_spiped_secret; \
    /usr/bin/spiped -e -s 127.0.0.1:10002 -t txbitsdocker_litecoind_1:10001 -k /secrets/litecoind_spiped_secret; \
    dockerize -template /templates/application.conf:/txbits/txbits-1.0-SNAPSHOT/conf/application.conf -template /templates/common.conf:/txbits/txbits-1.0-SNAPSHOT/conf/common.conf /bin/true && /txbits/txbits-1.0-SNAPSHOT/bin/txbits -Dconfig.file=/txbits/txbits-1.0-SNAPSHOT/conf/application.conf -Dhttp.port=80 -Dhttp.address=0.0.0.0 -J-Xms350m -J-Xmx350m -Djavax.net.ssl.trustStore=/txbits/txbits-1.0-SNAPSHOT/truststore -Djavax.net.ssl.trustStorePassword=password -Dpidfile.path=/dev/null
