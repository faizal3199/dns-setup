FROM ubuntu:xenial

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

RUN apt-get update && apt-get install -y apt-utils

RUN apt-get install -y dialog

RUN apt-get install -y resolvconf 

RUN apt-get install -y bc curl cron dnsutils iputils-ping lsof netcat psmisc sudo unzip wget idn2 sqlite3 dns-root-data debconf dhcpcd5 git iproute2 whiptail

RUN apt-get install -y --fix-missing lighttpd php-common php-cgi php-sqlite3

COPY pihole-custom-install.sh /pihole-custom-install.sh
COPY pihole-setupVars.conf /etc/pihole/setupVars.conf
COPY restart-pihole-services.sh /usr/local/bin/restart-pihole-services
COPY adlists.list /etc/pihole/adlists.list

WORKDIR /

RUN chown root:root /pihole-custom-install.sh /etc/pihole/setupVars.conf /usr/local/bin/restart-pihole-services /etc/pihole/adlists.list

RUN chmod 775 pihole-custom-install.sh && chmod 775 /usr/local/bin/restart-pihole-services

RUN ./pihole-custom-install.sh --unattended

HEALTHCHECK CMD dig @127.0.0.1 pi.hole || exit 1

CMD ["restart-pihole-services","restart","keep-alive"]