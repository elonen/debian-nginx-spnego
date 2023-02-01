FROM debian:bullseye

RUN echo "deb-src http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list.d/main-src.list
RUN apt-get -qy update
RUN apt-get -qy install git build-essential debhelper-compat dpkg-dev po-debconf debhelper-compat perl

# Cache some nginx build-deps
RUN apt-get -qy install	libkrb5-dev libhiredis-dev libluajit-5.1-dev libmaxminddb-dev libmhash-dev libpam0g-dev libperl-dev quilt libssl-dev libgd-dev

WORKDIR /root
RUN mkdir /root/OUTPUT
COPY Makefile nginx-spnego-deb.patch ./
