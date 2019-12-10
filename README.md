# MySQL Client for Docker

This image has been created to satisfy the following requirements:

- Based off a specific release of Alpine Linux - 3.10
- Includes a known release of the mysql client and tools such as mysqladmin - 10.3
- Avoids using the root user - uid=1000(mysql) gid=1000(mysql)



### Usage

When a container is run without arguments the MySQL client version will be displayed:

```
docker container run -it --rm logiqx/mysql-client
```

The MySQL client can be used interactively, connecting to a database as follows:

```
docker run -it --rm --network NETWORK_ID logiqx/mysql-client \
       mysql --host=HOSTNAME --database=DATABASE --user=USERNAME --password
```

Alternative MySQL command line tools such as "mysqladmin" can be run as follows:

```
docker run -it --rm --network NETWORK_ID logiqx/mysql-client \
       mysqladmin ping --wait --connect_timeout=60 --host=HOSTNAME --user=USERNAME --password
```

Note: The examples above will automatically prompt for the user password.



### Building a Custom Image

To build a custom image for a specific version of the MySQL client or Alpine use the following syntax:

```
docker image build --build-arg MYSQL_CLIENT_VERSION=10.3.20 . -t mysql-client:10.3.20
```

You can provide overrides for the following:

- MYSQL_CLIENT_VERSION- default of ~10.3
- ALPINE_VERSION - default of 3.10
- MYSQL_USER and MYSQL_GROUP - default of mysql
- MYSQL_UID and MYSQL_GID - default of 1000

