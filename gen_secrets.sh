#!/bin/sh

#openssl genrsa -out key.pem 2048
#openssl req -new -x509 -nodes -sha256 -days 3650 -key key.pem > cert.pem

#mkdir -p secrets/bitcoind
#pushd secrets/bitcoind
#dd if=/dev/urandom bs=32 count=1 of=spiped_secret
#popd
#
#mkdir -p secrets/litecoind
#pushd secrets/litecoind
#dd if=/dev/urandom bs=32 count=1 of=spiped_secret
#popd
