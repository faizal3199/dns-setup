#!/bin/bash

# start the dnscrypt server in bakground before the pi-hole service starts
/dnscrypt-files/dnscrypt-proxy -config /dnscrypt-files/dnscrypt-proxy.toml


serviceCMD=start

if [ ! -z "$1" ]; then
	serviceCMD=$1;
fi

service pihole-FTL "$serviceCMD" &&\
	service lighttpd "$serviceCMD"

# bring dnscrypt service to foreground
# if dnscrypt service fails the container will exit
if [ "$2" = "keep-alive" ]; then
	fg
fi