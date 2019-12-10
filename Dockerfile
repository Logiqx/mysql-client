ARG ALPINE_VERSION=3.10
FROM alpine:${ALPINE_VERSION}

ARG MYSQL_CLIENT_VERSION=~10.3

ARG MYSQL_USER=mysql
ARG MYSQL_GROUP=mysql
ARG MYSQL_UID=1000
ARG MYSQL_GID=1000

RUN apk add --no-cache tini=~0.18 mysql-client=${MYSQL_CLIENT_VERSION} && \
    addgroup -g ${MYSQL_GID} ${MYSQL_GROUP} && \
    adduser -u ${MYSQL_UID} --disabled-password ${MYSQL_USER} -G ${MYSQL_GROUP} && \
    mkdir /home/${MYSQL_USER}/work && \
    chown ${MYSQL_USER} /home/${MYSQL_USER}/work

USER ${MYSQL_USER}
WORKDIR /home/${MYSQL_USER}/work

# Wait for CMD to exit, reap zombies and perform signal forwarding
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["mysql", "--version"]
