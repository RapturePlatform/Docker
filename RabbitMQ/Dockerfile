FROM gliderlabs/alpine:3.3
MAINTAINER ukmoore

RUN apk --update upgrade && apk upgrade --update
ADD bin/rabbitmq-start /usr/local/bin/
RUN chmod 755 /usr/local/bin/rabbitmq-start

# Note that later rabbitmq version authenticate differently, stayed with what we know
ENV RABBITMQ_VERSION=3.5.6 ERLANG_PKG_VERSION=18.3-r0

# Setup Erlang, download RabbitMQ and setup the management plugin
RUN apk add --update curl tar gzip bash unzip && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --update-cache --allow-untrusted \
        erlang=${ERLANG_PKG_VERSION} erlang-mnesia=${ERLANG_PKG_VERSION} \
        erlang-public-key=${ERLANG_PKG_VERSION} erlang-crypto=${ERLANG_PKG_VERSION} \
        erlang-ssl=${ERLANG_PKG_VERSION} erlang-sasl=${ERLANG_PKG_VERSION} \
        erlang-asn1=${ERLANG_PKG_VERSION} erlang-inets=${ERLANG_PKG_VERSION} \
        erlang-os-mon=${ERLANG_PKG_VERSION} erlang-xmerl=${ERLANG_PKG_VERSION} erlang-eldap=${ERLANG_PKG_VERSION} && \
    curl -sSL https://www.rabbitmq.com/releases/rabbitmq-server/v${RABBITMQ_VERSION}/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.gz | tar -xz -C / --strip-components 1 && \
    rm -rf /share/**/rabbitmq*.gz && \
    apk del --purge tar gzip curl && \
    rm -rf /var/cache/apk/* && \
    addgroup rabbitmq && \
    adduser -DS -G rabbitmq -s /bin/sh -h /var/lib/rabbitmq rabbitmq && \
    mkdir -p /data/rabbitmq

# Define environment variables.
ENV RABBITMQ_LOG_BASE /data/log
ENV RABBITMQ_MNESIA_BASE /data/mnesia

# For Rapture access
RUN rabbitmq-plugins enable rabbitmq_management
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

# Define mount points.
VOLUME ["/data/log", "/data/mnesia"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["rabbitmq-start"]

# Expose ports.
EXPOSE 5672
EXPOSE 15672

LABEL Description="Launches docker with rabbitmq"
LABEL Usage="docker run -d -p 5672:5672 -p 15672:15672 --name rabbit rapture/rabbit"
LABEL Usage="docker run -d -p 5672:5672 -p 15672:15672 --name rabbit rapture/rabbit"
LABEL Build-instructions="docker build -t rapture/rabbit ."
