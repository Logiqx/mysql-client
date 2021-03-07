# MySQL Client for Docker

This image has been created to satisfy the following requirements:

- Use official base images - Alpine and Debian (slim)
- Use specific release of the mysql client and tools such as mysqladmin
- Avoid running as the root user



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



#### Using the Debian Image

The Debian image is used in much the same way as the Alpine image by specifying the appropriate tag:

```
docker container run -it --rm logiqx/mysql-client:slim
```



### Building a Custom Image

To build a custom image for a specific version of the MySQL client or Alpine use the following syntax:

```
docker image build --build-arg MYSQL_CLIENT_VERSION=10.5.9 . -t mysql-client:10.5.9
```

To build a custom Debian image simply use Dockerfile-slim instead of Dockerfile:

```
docker image build --file Dockerfile-slim --build-arg MYSQL_CLIENT_VERSION=10.5.9 . -t mysql-client:10.5.9-slim
```

You can provide overrides for the following:

- MYSQL_CLIENT_VERSION - default of ~10.5
- ALPINE_VERSION / DEBIAN_VERSION - default of 3.13 / buster
- MYSQL_USER and MYSQL_GROUP - default of mysql
- MYSQL_UID and MYSQL_GID - default of 1000

