FROM ubuntu:xenial

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

RUN apt-get update && apt-get install -y apt-utils

RUN apt-get install -y dialog

RUN apt-get install -y resolvconf

RUN apt-get install -y bc curl cron dnsutils iputils-ping lsof netcat psmisc sudo unzip wget idn2 sqlite3 dns-root-data debconf dhcpcd5 git iproute2 whiptail

RUN apt-get install -y --fix-missing lighttpd php-common php-cgi php-sqlite3

RUN update-ca-certificates

COPY pi-hole-files/pihole-custom-install.sh /pihole-custom-install.sh
COPY pi-hole-files/pihole-setupVars.conf /etc/pihole/setupVars.conf
COPY pi-hole-files/adlists.list /etc/pihole/adlists.list
COPY pi-hole-files/pihole-FTL.conf /etc/pihole/pihole-FTL.conf

WORKDIR /

ENV CLOUDFLARED_DOWNLOAD_URL https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz

RUN wget ${CLOUDFLARED_DOWNLOAD_URL} -O cloudflared.tar.gz

RUN tar -xvzf cloudflared.tar.gz && \
    rm -rf cloudflared.tar.gz && \
    chown root:root ./cloudflared && \
    chmod +x ./cloudflared

RUN chown root:root /pihole-custom-install.sh /etc/pihole/setupVars.conf /etc/pihole/adlists.list

RUN chmod 775 pihole-custom-install.sh

RUN ./pihole-custom-install.sh --unattended

COPY restart-services.sh /usr/local/bin/restart-services
RUN chown root:root /usr/local/bin/restart-services && chmod 775 /usr/local/bin/restart-services

HEALTHCHECK --interval=300s --timeout=2s --start-period=10s CMD dig @127.0.0.1 example.com || exit 1

CMD ["restart-services","restart"]
