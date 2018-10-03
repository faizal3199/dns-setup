#!/bin/bash

serviceCMD=start

if [ ! -z "$1" ]; then
	serviceCMD=$1;
fi

service pihole-FTL "$serviceCMD" &&\
	service lighttpd "$serviceCMD"

if [ "$2" = "keep-alive" ]; then
	while true
	do
		timeout 2 dig @127.0.0.1 pi.hole || exit 1
		sleep 5
	done
fi