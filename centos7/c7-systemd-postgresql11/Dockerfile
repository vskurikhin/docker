FROM centos:7

COPY certs.tgz /root/
COPY scripts.tgz /root/

ENV container docker

RUN (cd /; for f in /root*.tgz; do \
tar xzf $f && rm -f $f; done) && update-ca-trust ; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*; \
rm -f /root/*.tgz; \
sh /root/install-postgres.sh; \
systemctl enable remain-after-exit.service; \
yum install -y vim-enhanced

VOLUME [ "/sys/fs/cgroup", "/var/lib/pgsql" ]

CMD ["/usr/sbin/init"]
