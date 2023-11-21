ARG DEBIAN_VERSION=bullseye

FROM debian:${DEBIAN_VERSION}
ARG DEBIAN_VERSION

# Add the appropriate source list for the given Debian version
RUN rm -f /etc/apt/sources.list.d/*
RUN echo "deb http://deb.debian.org/debian ${DEBIAN_VERSION} main" >> /etc/apt/sources.list.d/main-src.list
RUN echo "deb http://deb.debian.org/debian ${DEBIAN_VERSION}-updates main" >> /etc/apt/sources.list.d/main-src.list
RUN echo "deb http://deb.debian.org/debian-security ${DEBIAN_VERSION}-security main" >> /etc/apt/sources.list.d/main-src.list
RUN echo "deb-src http://deb.debian.org/debian ${DEBIAN_VERSION} main" >> /etc/apt/sources.list.d/main-src.list
RUN echo "deb-src http://deb.debian.org/debian ${DEBIAN_VERSION}-updates main" >> /etc/apt/sources.list.d/main-src.list
RUN echo "deb-src http://deb.debian.org/debian-security ${DEBIAN_VERSION}-security main" >> /etc/apt/sources.list.d/main-src.list
RUN apt-get -qy update
RUN apt-get -qy install git build-essential debhelper-compat dpkg-dev po-debconf debhelper-compat perl

# Cache some nginx build-deps
RUN apt-get -qy install nginx-common comerr-dev libkrb5-dev libhiredis-dev libluajit-5.1-dev libmaxminddb-dev libmhash-dev libpam0g-dev libperl-dev quilt libssl-dev libgd-dev libgeoip-dev libpcre3-dev libgeoip-dev libxslt1-dev

WORKDIR /root
RUN mkdir TARGET
RUN git clone https://github.com/stnoonan/spnego-http-auth-nginx-module.git TARGET/spnego-http-auth-nginx-module
RUN mkdir /root/OUTPUT
COPY . .
