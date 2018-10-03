#!/bin/bash

docker network create --subnet=172.20.53.0/24 dns-network 2>/dev/null

# Run from docker-files folder
docker build -t pi-hole-setup:latest .

docker run -d \
        --net dns-network \
        --ip 172.20.53.53 \
        --name pihole-dns-server \
        --cap-add=NET_ADMIN \
        --restart=unless-stopped \
        pi-hole-setup:latest