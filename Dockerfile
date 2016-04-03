FROM ubuntu:14.04

MAINTAINER Commande-Online.fr SAS

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" > /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

RUN apt-key update

RUN apt-get update -q ;\
    apt-get upgrade -y -q

RUN apt-get install -y -q php5-dev php5-mcrypt php5-curl php5-mysql php5-mongo php5-memcached php5-xdebug php-apc php5-imagick php5-gd php5-geoip gcc git libpcre3-dev php5-fpm

RUN git clone --depth=1 git://github.com/phalcon/cphalcon.git /usr/local/src/cphalcon
RUN cd /usr/local/src/cphalcon/build && ./install ;\
    echo "extension=phalcon.so" > /etc/php5/mods-available/phalcon.ini ;\
    php5enmod phalcon

RUN apt-get clean

ENV DEBIAN_FRONTEND dialog