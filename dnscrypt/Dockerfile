FROM ubuntu:xenial

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get install -y apt-utils 
RUN apt-get install -y curl wget && update-ca-certificates

ENV DNSCRYPT_PROXY_VERSION 2.0.17
ENV SYSTEM linux
ENV ARCH x86_64
ENV SYSTEM_ARCH ${SYSTEM}_${ARCH}
ENV SYSTEM__ARCH ${SYSTEM}-${ARCH}
ENV DNSCRYPT_PROXY_DOWNLOADURL https://github.com/jedisct1/dnscrypt-proxy/releases/download/${DNSCRYPT_PROXY_VERSION}/dnscrypt-proxy-${SYSTEM_ARCH}-${DNSCRYPT_PROXY_VERSION}.tar.gz

COPY dnscrypt-proxy.toml /dnscrypt-proxy.toml

WORKDIR /

RUN wget ${DNSCRYPT_PROXY_DOWNLOADURL} -O dnscrypt-proxy.tar.gz

RUN tar -xvzf dnscrypt-proxy.tar.gz && \
    mv ${SYSTEM__ARCH} dnscrypt-files && \
    rm -rf /dnscrypt-proxy.tar.gz && \
    cd dnscrypt-files && \
    chown root:root /dnscrypt-proxy.toml && \
    mv /dnscrypt-proxy.toml ./ && \
    ./dnscrypt-proxy -check

HEALTHCHECK CMD dig @127.0.0.1 google.com || exit 1

CMD /dnscrypt-files/dnscrypt-proxy -config /dnscrypt-files/dnscrypt-proxy.toml