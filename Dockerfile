FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    HOME="/root" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    TERM="xterm" \
    EDITOR="vim"

RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list \
 && sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list \
 && sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list \
 && apt-get update -y --no-install-recommends \
 && apt-get upgrade -y --no-install-recommends \
 && apt-get install -y --no-install-recommends \
     ca-certificates \
     software-properties-common \
     language-pack-en \
     curl \
     vim-tiny \
     tar \
     xdg-utils \
     wget \
     xz-utils \
 && apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold" \
 && locale-gen en_US \
 && update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/* \
           /var/log/* \
 && useradd -u 911 -U -d /config -s /bin/false abc \
 && usermod -G users abc \
 && mkdir -p /config  \
             /defaults \
             /app

COPY entrypoint.sh /entrypoint.sh

ARG GOSU_VERSION=1.17
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true \
 && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
