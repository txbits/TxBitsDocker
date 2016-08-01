FROM txbits-run-base

ADD litecoind/templates/coind.conf /coind.conf
ADD bin/dockerize /usr/bin/dockerize
ADD bin/litecoind /usr/bin/litecoind

CMD dockerize -template /coind.conf:/root/coind.conf /usr/bin/litecoind -datadir=/data -conf=/root/coind.conf -daemon=0
