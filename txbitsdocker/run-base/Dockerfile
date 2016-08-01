FROM debian:wheezy

ADD GPG-KEY-java8 /root/GPG-KEY-java8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-key add /root/GPG-KEY-java8 && \
        echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
        echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
        echo 'deb http://archive.debian.org/debian squeeze main contrib non-free' >> /etc/apt/sources.list && \
        echo 'deb-src http://archive.debian.org/debian squeeze main contrib non-free' >> /etc/apt/sources.list && \
        echo 'debconf shared/accepted-oracle-license-v1-1 select true' | /usr/bin/debconf-set-selections && \
        echo 'debconf shared/accepted-oracle-license-v1-1 seen true' | /usr/bin/debconf-set-selections && \
        apt-get update && \
        apt-get install -y libboost-all-dev openssl libdb4.8 libdb4.8++ libglib2.0 oracle-java8-installer zlib1g e2fslibs && \
        rm -r /var/lib/apt/lists
