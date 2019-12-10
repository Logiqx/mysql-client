ARG ALPINE_VERSION=3.10
FROM alpine:${ALPINE_VERSION}

ARG MYSQL_CLIENT_VERSION=~10.3
RUN apk add --no-cache tini=~0.18 mysql-client=${MYSQL_CLIENT_VERSION}

ARG MYSQL_USER=mysql
ARG MYSQL_GROUP=mysql
ARG MYSQL_UID=1000
ARG MYSQL_GID=1000

RUN addgroup -g ${MYSQL_GID} ${MYSQL_GROUP} && \
    adduser -u ${MYSQL_UID} --disabled-password ${MYSQL_USER} -G ${MYSQL_GROUP} && \
    mkdir -p /home/${MYSQL_USER}/work && \
    chown -R ${MYSQL_USER}:${MYSQL_GROUP} /home/${MYSQL_USER}

USER ${MYSQL_USER}
WORKDIR /home/${MYSQL_USER}/work

# Wait for CMD to exit, reap zombies and perform signal forwarding
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["mysql", "--version"]
