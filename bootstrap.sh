#!/bin/sh
docker-compose up -d
docker exec txbitsdocker_db_1 sh -c 'psql --user postgres < /dbinfo/init.sql'
