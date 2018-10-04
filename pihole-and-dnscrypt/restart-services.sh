#!/bin/bash

serviceCMD=start

if [ ! -z "$1" ]; then
	serviceCMD=$1;
fi

service pihole-FTL "$serviceCMD" &&\
	service lighttpd "$serviceCMD"

# start the dnscrypt server in foreground
# if dnscrypt service fails the container will exit
/dnscrypt-files/dnscrypt-proxy -config /dnscrypt-files/dnscrypt-proxy.toml