FROM docker.io/teodorescuserban/pspc-base-mysql:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ADD run /etc/service/mysql/run

RUN chmod +x /etc/service/mysql/run && \
    sed -i 's/^datadir\s*.*/datadir = \/srv\/db/' /etc/mysql/my.cnf && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh

EXPOSE 3306

VOLUME ["/srv/db"]

CMD ["/sbin/my_init"]
