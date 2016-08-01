FROM txbits-run-base

ADD bin/dockerize /usr/bin/dockerize
ADD bin/txbits /txbits

ADD frontend/logback.xml /txbits/txbits-1.0-SNAPSHOT/conf/logback.xml
ADD frontend/txbits_truststore /txbits/txbits-1.0-SNAPSHOT/truststore
ADD frontend/templates/common.conf /common.conf
ADD frontend/templates/wallet.conf /wallet.conf
ADD frontend/templates/frontend.conf /frontend.conf

CMD dockerize -template $([ -z "${IS_WALLET}" ] && echo /wallet.conf || echo /frontend.conf):/txbits/txbits-1.0-SNAPSHOT/conf/application.conf -template /common.conf:/txbits/txbits-1.0-SNAPSHOT/conf/common.conf /bin/true && /txbits/txbits-1.0-SNAPSHOT/bin/txbits -Dconfig.file=/txbits/txbits-1.0-SNAPSHOT/conf/application.conf -Dhttp.port=80 -Dhttp.address=0.0.0.0 -J-Xms350m -J-Xmx350m -Djavax.net.ssl.trustStore=/txbits/txbits-1.0-SNAPSHOT/truststore -Djavax.net.ssl.trustStorePassword=password -Dpidfile.path=/dev/null
