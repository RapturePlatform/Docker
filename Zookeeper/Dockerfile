FROM gliderlabs/alpine:3.3

MAINTAINER ukmoore

ENV ZOOKEEPER_VERSION 3.4.6

# About nsswitch.conf - see https://registry.hub.docker.com/u/frolvlad/alpine-oraclejdk8/dockerfile/
COPY rootfs /

# S6 is a process manager (helps with DNS)
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.13.0.0/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C / && \
  apk -U add dnsmasq jq curl && \
  chmod 755 /bin/*.sh /etc/services.d/dns/run /etc/cont-init.d/dns_init.sh /etc/services.d/dns-hack/run /etc/services.d/syslog/run && \
  mkdir /app && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
  addgroup -g 998 app && \
  adduser -D  -G app -s /bin/false -u 998 app

RUN apk --update upgrade
RUN apk-install bash openjdk8-jre ca-certificates && apk-install bash

ADD entry.sh /entry.sh

ADD zoo.cfg.toml /etc/confd/conf.d/
ADD myid.toml /etc/confd/conf.d/
ADD myid.tmpl /etc/confd/templates/
ADD zoo.cfg.tmpl /etc/confd/templates/

ADD http://mirror.metrocast.net/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz /opt/
RUN cd /opt && \
    tar -zxvf zookeeper-3.4.6.tar.gz && \
    mv zookeeper-3.4.6 zookeeper && \
    rm -rf ./zookeeper-*tar.gz && \
    mkdir -p /var/lib/zookeeper

ADD https://github.com/kelseyhightower/confd/releases/download/v0.9.0/confd-0.9.0-linux-amd64 /confd
RUN chmod +x /confd

WORKDIR /opt/zookeeper
EXPOSE 2181 2888 3888
VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT [ "/init" ]
CMD ["/entry.sh"]
