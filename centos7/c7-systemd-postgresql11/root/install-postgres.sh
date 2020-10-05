#!/bin/sh

packages="
postgresql11-11.8-1PGDG.rhel7.x86_64.rpm
postgresql11-contrib-11.8-1PGDG.rhel7.x86_64.rpm
postgresql11-libs-11.8-1PGDG.rhel7.x86_64.rpm
postgresql11-plpython-11.8-1PGDG.rhel7.x86_64.rpm
postgresql11-server-11.8-1PGDG.rhel7.x86_64.rpm
"
path=download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/
location=https://$path
work_dir=/tmp/postgresql11

mkdir /tmp/postgresql11

for package in $packages
do
  curl --cacert /etc/ssl/certs/ca-bundle.crt $location$package -o $work_dir/$package
done

yum install -y $work_dir/postgresql11*rpm

/usr/pgsql-11/bin/postgresql-11-setup initdb
/bin/systemctl enable postgresql-11.service
/bin/systemctl start postgresql-11.service

rm -rf $work_dir
rm -f $0
