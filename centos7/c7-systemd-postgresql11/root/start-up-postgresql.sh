#!/bin/sh
/usr/pgsql-11/bin/postgresql-11-setup initdb
/bin/systemctl enable postgresql-11.service
/bin/systemctl start postgresql-11.service
rm -f $0
