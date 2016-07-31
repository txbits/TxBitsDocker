all: build

build:
	docker-compose build

up:
	docker-compose up -d

.PHONY: all
