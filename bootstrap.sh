#!/bin/sh
docker-compose build
docker-compose --x-networking up -d
docker exec txbitsdocker_db_1 sh -c 'psql --user postgres < /dbinfo/init.sql'
