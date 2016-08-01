FROM txbits-run-base

ADD bitcoind/templates/coind.conf /coind.conf
ADD bin/dockerize /usr/bin/dockerize
ADD bin/bitcoind /usr/bin/bitcoind

CMD dockerize -template /coind.conf:/root/coind.conf /usr/bin/bitcoind -datadir=/data -conf=/root/coind.conf -daemon=0
