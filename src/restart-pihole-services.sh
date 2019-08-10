#!/bin/bash

serviceCMD=start

if [ ! -z "$1" ]; then
	serviceCMD=$1;
fi

service pihole-FTL "$serviceCMD" && \
	service lighttpd "$serviceCMD"

if [ "$2" = "keep-alive" ]; then
	while true
	do
		sleep 5
	done
fi