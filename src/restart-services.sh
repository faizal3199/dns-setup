#!/bin/bash

serviceCMD=start

if [ ! -z "$1" ]; then
	serviceCMD=$1;
fi

service pihole-FTL "$serviceCMD" &&\
	service lighttpd "$serviceCMD"

# start the dns server(cloudflared) in foreground
# if dns service fails the container will exit
/cloudflared proxy-dns --address 127.0.5.3 --port 530