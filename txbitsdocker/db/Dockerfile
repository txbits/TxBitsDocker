FROM postgres:9.3

ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
ADD init.sql /root/init.sql
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

RUN su postgres -c '/usr/lib/postgresql/9.3/bin/postmaster -D /var/lib/postgres/data& PID=!? && psql -c "create database txbits;" && psql txbits < /root/init.sql && kill $PID'

CMD su postgres -c '/usr/lib/postgresql/9.3/bin/postmaster -D /var/lib/postgres/data'
