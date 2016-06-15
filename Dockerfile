FROM ubuntu:16.04

MAINTAINER Commande-Online.fr SAS

ENV DEBIAN_FRONTEND noninteractive

#RUN echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" > /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

RUN apt-get update -q ;\
    apt-get upgrade -y -q

RUN apt-get install software-properties-common python-software-properties -y ;\
    apt-get install -y language-pack-en-base
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-key update

RUN apt-get update -q ;\
    apt-get upgrade -y -q

RUN apt-get install -y -q php5.6-dev php5.6-mcrypt php5.6-curl php5.6-mysql php5.6-mongo php5.6-memcached php5.6-xdebug php5.6-apc php5.6-imagick php5.6-gd php5.6-geoip gcc git libpcre3-dev php5.6-fpm

RUN git clone --depth=1 git://github.com/phalcon/cphalcon.git /usr/local/src/cphalcon
RUN cd /usr/local/src/cphalcon/build && ./install
RUN echo "extension=phalcon.so" > /etc/php/5.6/mods-available/phalcon.ini ;\
    echo "extension=phalcon.so" > /etc/php/7.0/mods-available/phalcon.ini ;\
    phpenmod phalcon

RUN apt-get clean

ENV DEBIAN_FRONTEND dialog