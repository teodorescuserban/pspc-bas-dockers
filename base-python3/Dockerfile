FROM docker.io/teodorescuserban/pspc-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get -qq update && \
    apt-get -qq -y install \
        libxml2-dev \
        libxslt1-dev \
        mysql-client-5.5 \
        zlib1g-dev \
        python3-dev \
        python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip3 -q install --upgrade \
        gunicorn \
        gevent \
        lxml \
        virtualenv
