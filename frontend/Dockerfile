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
RUN git clone https://github.com/txbits/txbits.git && cd txbits && git checkout v0.2.0 && ./txbits.sh universal:packageZipTarball
RUN mkdir /txbits && tar -zxvf /root/txbits/txbits/target/universal/txbits-1.0-SNAPSHOT.tgz --directory /txbits && rm -rf /root/txbits

ADD logback.xml /txbits/txbits-1.0-SNAPSHOT/conf/logback.xml
ADD txbits_truststore /txbits/txbits-1.0-SNAPSHOT/truststore

RUN wget https://github.com/jwilder/dockerize/releases/download/v0.0.3/dockerize-linux-amd64-v0.0.3.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.0.3.tar.gz

CMD dockerize -template /templates/application.conf:/txbits/txbits-1.0-SNAPSHOT/conf/application.conf -template /templates/common.conf:/txbits/txbits-1.0-SNAPSHOT/conf/common.conf /bin/true && /txbits/txbits-1.0-SNAPSHOT/bin/txbits -Dconfig.file=/txbits/txbits-1.0-SNAPSHOT/conf/application.conf -Dhttp.port=80 -Dhttp.address=0.0.0.0 -J-Xms350m -J-Xmx350m -Djavax.net.ssl.trustStore=/txbits/txbits-1.0-SNAPSHOT/truststore -Djavax.net.ssl.trustStorePassword=password -Dpidfile.path=/dev/null
