#!/bin/bash

docker network create --subnet=172.20.53.0/24 dns-network 2>/dev/null

# Run from docker-files folder
docker build -t dnscrypt-proxy:latest ./src/

docker run -d \
		--net dns-network \
		--ip 172.20.53.54 \
		--name dnscrypt-server \
		--cap-add=NET_ADMIN \
		--restart=unless-stopped \
		dnscrypt-proxy:latest
