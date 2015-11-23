FROM docker.io/teodorescuserban/pspc-base-python3:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ADD init.sh gunicorn_conf.py /srv/

RUN mkdir -p /etc/service/wsgi && \
    echo "#!/bin/bash\nset -e\ncd /srv/bas-api\nexec gunicorn bas-api:application -c /srv/gunicorn_conf.py\n" > /etc/service/wsgi/run && \
    chmod +x /etc/service/wsgi/run && \
    mkdir -p /var/log/wsgi && \
    virtualenv -p /usr/bin/python3 /srv && \
    git clone https://github.com/PWGSC-DEEN/procurement-data-api.git /srv/bas-api && \
    cd /srv/bas-api && \
    . /srv/bin/activate && \
    pip3 install -e . && \
    cp -a bas-api.wsgi.TEMPLATE bas-api.wsgi && \
    echo "12 5 * * * root cd /srv/bas-api && /bin/sh update-tenders.sh" >> /etc/crontab && \
    echo "12 6 * * 0 root cd /srv/bas-api && /bin/sh update-contracts.sh" >> /etc/crontab && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh


#    pip3 install virtualenv && \
#    python3 setup.py build && \
#    pip3 install pymysql && \
#    pip3 install flask && \

EXPOSE 5000

VOLUME ["/var/log/wsgi", "/srv/files"]

CMD ["/sbin/my_init"]
