FROM centos:7

COPY certs.tgz /root/
COPY scripts.tgz /root/

ENV container docker

RUN (cd /; for f in /root/*.tgz; do \
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
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-TISSAMBA-7 \
systemctl enable remain-after-exit.service; \
yum install -y vim-enhanced epel-release; \
yum install -y samba samba-winbind samba-winbind-clients krb5-workstation ldb-tools bind chrony bind-utils samba-client python3-crypto; \
rm -f /etc/samba/smb.conf; \
samba-tool domain provision --realm=SIGMA.EXAMPLE.COM --domain SIGMA --server-role=dc; \
cp -f /root/krb5.conf /etc/krb5.conf

EXPOSE 137/udp 138/udp 139 389 445 636

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]
