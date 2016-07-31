all: up

_ := $(shell \
git submodule init)

build: run-base txbitsdocker/bin/bitcoind txbitsdocker/bin/litecoind txbitsdocker/bin/txbits
	docker-compose build

up: build
	docker-compose up --build -d

build-base: ./txbitsdocker/build-base
	docker build -t txbits-build-base ./txbitsdocker/build-base

run-base: ./txbitsdocker/run-base
	docker build -t txbits-run-base ./txbitsdocker/run-base

db_init:
	docker exec txbitsdocker_db_1 sh -c 'psql --user postgres < /dbinfo/init.sql'

txbitsdocker/bin:
	mkdir -p txbitsdocker/bin

txbitsdocker/bin/bitcoind: build-base txbitsdocker/bin
	docker run -ti --rm --user $(shell id -u) -v $(shell pwd)/txbitsdocker/bin:/output -v $(shell pwd)/bitcoind:/code txbits-build-base sh -c 'cd /code && \
		./autogen.sh && \
		./configure && \
		make -j 4 && \
		cp ./src/bitcoind /output/'

txbitsdocker/bin/litecoind: build-base txbitsdocker/bin
	docker run -ti --rm --user $(shell id -u) -v $(shell pwd)/txbitsdocker/bin:/output -v $(shell pwd)/litecoind:/code txbits-build-base sh -c 'cd /code && \
		./autogen.sh && \
		./configure && \
		make -j 4 && \
		cp ./src/litecoind /output/'

# TODO: build this from source
txbitsdocker/bin/dockerize: build-base txbitsdocker/bin
	docker run -ti --rm --user $(shell id -u) -v $(shell pwd)/txbitsdocker/bin:/output txbits-build-base sh -c 'cd /tmp && \
		wget https://github.com/jwilder/dockerize/releases/download/v0.0.3/dockerize-linux-amd64-v0.0.3.tar.gz && \
		tar -C /output -xzvf dockerize-linux-amd64-v0.0.3.tar.gz'

txbitsdocker/bin/txbits: build-base txbitsdocker/bin
	docker run -ti --rm --user $(shell id -u) -v $(shell pwd)/sbt-cache:/tmp/home/.sbt -v $(shell pwd)/ivy2-cache:/tmp/home/.ivy2 -v $(shell pwd)/txbitsdocker/bin:/output -v $(shell pwd)/txbits:/code txbits-build-base sh -c 'cd /tmp && \
		/code/txbits.sh -v -Dsbt.boot.properties=/sbt.boot.properties universal:packageZipTarball && \
		mkdir /tmp/extracted && \
		tar -zxvf /code/txbits/target/universal/txbits-1.0-SNAPSHOT.tgz --directory /tmp/extracted && \
		cp -r /tmp/extracted/ /output/txbits'

.PHONY: all build up db_init
