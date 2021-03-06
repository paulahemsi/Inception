# Inception
 System Administration Exercise :whale:

* [diagram](#diagram)
* [folder_structure](#folder_structure)
* [containers](#containers)
* [containers_vs_virtual_machines](#containers_vs_virtual_machines)
* [dockerfile](#dockerfile)
* [docker_image](#docker_image)
* [docker_compose](#docker_compose)
* [docker_CLI_commands](#docker_CLI_commands)
* [Defining Environment Variables](#Defining_Environment_Variables)
* [nginx](#nginx)
* [mysql](#mysql)
* [Socket](#Socket)
* [study_resources](#study_resources)

[wiki](https://github.com/paulahemsi/Inception/wiki)

## diagram

![image](https://user-images.githubusercontent.com/63563271/165197599-71613196-1daa-47d5-97bd-5155d581ec72.png)


## folder_structure

    │   
    ├── srcs
    │   ├──requirements
    |   |      ├──bonus 
    |   |      |    └──...
    |   |      ├──mariadb  
    |   |      |    ├──conf
    |   |      |    ├──Dockerfile         
    |   |      |    ├──.dockerignore
    |   |      |    └──tools
    |   |      ├──nginx
    |   |      |    ├──conf
    |   |      |    ├──Dockerfile         
    |   |      |    ├──.dockerignore
    |   |      |    └──tools
    |   |      ├──tools  
    |   |      |    └──...
    |   |      └──wordpress
    |   |           └──...
    |   ├── .env
    |   └── docker-compose.yml         
    └── Makefile 
 
## containers
 
 So, first things first: what a hell is a container?
 
**A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another.**

A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

Container images become containers at runtime and in the case of Docker containers – images become containers when they run on Docker Engine. Available for both Linux and Windows-based applications, containerized software will always run the same, regardless of the infrastructure. Containers isolate software from its environment and ensure that it works uniformly despite differences for instance between development and staging.


## containers_vs_virtual_machinesservice --status-all
![image](https://user-images.githubusercontent.com/63563271/165406602-7fdf7260-5f29-448f-82a1-82bb8030817c.png)
from [docker](https://www.docker.com/resources/what-container/)

> `ps -aux` list all the processes running, inside a container the main process should be at PID 1 

## dockerfile
 
Docker builds images automatically by reading the instructions from a Dockerfile -- a text file that contains all commands, in order, needed to build a given image.

Every line in a dockerfile will create a layer. Layers are intermediate images, if you make a change to your Dockerfile, docker will build only the layer that was changed and the ones after that.

The image defined by your Dockerfile should generate containers that are as ephemeral as possible. By “ephemeral”, we mean that the container can be stopped and destroyed, then rebuilt and replaced with an absolute minimum set up and configuration.

Dockerfile is structure with:

```
INSTRUCTION arguments
```

The instruction is not case-sensitive. However, convention is for them to be UPPERCASE to distinguish them from arguments more easily.

|INSTRUCTION| argument | Overview |
|-----------|----------|----------|
|`FROM`|*image* |base image foi the build |
|`MAINTAINER`|*e-mail* |name of the maintainer |
| `COPY`| *path dest* | copy *path* from the context into *dest* inside the container|
|`ADD` | *src dst* | same as copy + accepts http urls + untar archives |
|`RUN` | *args....* | run a command inside the container |
|`USER` | *name* | set the default username |
|`WORKDIR`| *path* | set the dafault working directory |
|`CMD` | *args...* | set the default command |
|`ENV` | *name value* | set an environment variable |
| `ENTRYPOINT`| *command param1 param2* | configures a container that will run as an executable |
|`EXPOSE` | *port* | documents wich ports are the container listening to |
|`VOLUME`| *path* | creates a mount point for externally mounted volumes or other containers |
|`STOPSIGNAL` | *signal* | sets the system call signal that will be sent to the container to exit |
|`SHELL` | *["executable", "parameters"]* |  allows the default shell used for the shell form of commands to be overridden |
|`HEALTCHECK`| *[OPTIONS] CMD command* | tells docker how to test a container to check that it is still working |

### ENTRYPOINT

The best use for `ENTRYPONT` is to set the image's main command, allowing that image to be run as thought it was that command (and then use CMD as the default flags).

### CMD and ENTRYPOINT

Both `CMD` and `ENTRYPOINT` instructions define what command gets executed when running a container. There are few rules that describe ther co-operation.

* Dockerfile should specify at least one of `CMD` or `ENTRYPOINT` commands
* `ENTRYPOINT` should be defined when using the container as an executable
* `CMD` should be used as a way of defining default arguments for an `ENTRYPOINT` command or for executing an ad-hoc command in a container
* `CMD`will be overridden when running the container with alternative arguments



## docker_image

A docker image ia a template of instructions that are used to create containers.
A docker image is built using the dockerfile.

## docker_compose

A docker compose is used for running multiple containers as a single service. In compose service, each container runs in isolarion but can interact with each other with no limitations 

The `docker-compose.yml` file will contain the service definitions for the setup. A **service** in Compose is a **running container**, and service definitions specify information about how each container will run.

Using Compose, you can define different services in order to run multi-container applications, since Compose allows you to link these services together with shared networks and volumes.

```yml
# docker-compose.yml
version: '1'

services:
  web:
    build: .
    # build from Dockerfile
    context: ./Path
    dockerfile: Dockerfile
    ports:
     - "5000:5000"
    volumes:
     - .:/code
  redis:
    image: redis

# ports
ports:
  - "3000"
  - "8000:80"  # guest:host
# expose ports to linked services (not to host)
expose: ["3000"]

# command to execute
command: bundle exec thin -p 3000
command: [bundle, exec, thin, -p, 3000]

# override the entrypoint
entrypoint: /app/start.sh
entrypoint: [php, -d, vendor/bin/phpunit]

# environment vars
environment:
  RACK_ENV: development
environment:
  - RACK_ENV=development

# environment vars from file
env_file: .env
env_file: [.env, .development.env]

# dependencies
# makes the `db` service available as the hostname `database`
# (implies depends_on)
links:
  - db:database
  - redis

# make sure `db` is alive before starting
depends_on:
  - db

# make this service extend another
extends:
  file: common.yml  # optional
  service: webapp
volumes:
  - /var/lib/mysql
  - ./_data:/var/lib/mysql
  
# DNS servers
services:
  web:
    dns: 8.8.8.8
    dns:
      - 8.8.8.8
      - 8.8.4.4

#hosts
services:
  web:
    extra_hosts:
      - "somehost:192.168.1.100"

# network
# creates a custom network called `frontend`
networks:
  frontend:
# join a preexisting network
networks:
  default:
    external:
      name: frontend
```

from [devhints](https://devhints.io/docker-compose) in [jonlabelle](https://gist.github.com/jonlabelle/bd667a97666ecda7bbc4f1cc9446d43a)

## docker_CLI_commands

|command| action |
|-----------|----------|
|`docker run <IMAGE>`|Start a new Container from an Image|
|`docker run --name <NAME> <IMAGE>`|Start a new Container from an Image with custom name |
|`docker run -p <HOST_PORT>:<CONTAINER_PORT> <IMAGE>`| Start a new Container from an Image and map a port|
|`docker run -d <IMAGE>`|Start a new Container in background|
|`docker run --hostname <HOSTNAME> <IMAGE>`| Start a new Container and assign it a hostname|
|`docker run --add-host <HOSTNAME>:<IP> <IMAGE>`| Start a new Container and add a dns entry |
|`docker run -it --entryopoint <EXECUTABLE> <IMAGE>`| Start a new Container but change the entrypoint|
| | |
|`docker ps`| Show a list of running containers |
|`docker ps -a`| Show a list of all containers |
| `docker rm <CONTAINER>`| Delete a container |
|`docker rm -f <CONTAINER>`| Force to delete a running container |
|`docker container prune`| Removes all stopped containers |
|`docker stop <CONTAINER>`| Stop a running container |
|`docker start <CONTAINER>`| Start a stopped container |
|`docker exec -it <CONTAINER> <EXECUTABLE>`| Start a shell inside a running container |
|`docker rename <OLD_NAME> <NEW_NAME>`| Rename a container |
| | |
|`docker pull <IMAGE>[:TAG]`| Download an image |
|`docker rmi <IMAGE>`| Delete an image |
|`docker images`| Show a list of all image |
|`docker images prune -a`| Delete all unused images |
|`docker build <DIRECTORY>`| Build an image from a Dockerfile |
|`docker tag <IMAGE> <NEW_IMAGE>`| Tag an image |
|`docker build -t <IMAGE> <DIRECTORY>`| Build and tag an image from a Dockerfile |
|`docker save <IMAGE> > <FILE>`| Save an image to .tar file |
|`docker load -i <FILE>`| Load an image from a .tar file |
| | |
|`docker logs <CONTAINER>`| Show the logs of a container |
|`docker stats`| Show stats of running containers |
|`docker top <CONTAINER>`| Show processes of container |
|`docker version`| Show installed docker version |
|`docker inspect <CONTAINER>`| Get detailed info (json format) about an object |
|`docker diff <CONTAINER>`| Show all modified files in container |
|`docker port <CONTAINER>`| Show mapped ports of a container |
|`docker-compose start` | Starts existing containers for a service|
|`docker-compose stop` | Stops running containers |
|`docker-compose pause` | Pauses running containers of a service |
|`docker-compose unpause` | Unpauses paused containers of a service |
|`docker-compose ps` | Lists containers |
|`docker-compose up` | Builds, (re)creates, starts, and attaches to containers for a service |
|`docker-compose down` | Stops containers and removes containers, networks, volumes, and images created by up |
|`docker-compose config` | shows compose configurations, including env variables|



more in [The Ultimate Docker Cheat Sheet](https://dockerlabs.collabnix.com/docker/cheatsheet/) and [docker-compose-cheatsheet](https://jonlabelle.com/snippets/view/markdown/docker-compose-cheatsheet)


## nginx


NGINX is a web server designed for use cases involving high volumes of traffic. It’s a popular, lightweight, high-performance solution.

One of its many impressive features is that it can serve static content (media files, HTML) efficiently. NGINX utilizes an asynchronous event-driven model, delivering reliable performance under significant loads.

> *tip!* `service --status-all` lists the state of services controlled by System V (**nginx** included)

> *tip!* `nginx -t` shows configuration problems 

### configuration


from [nginx configuration guide](https://www.plesk.com/blog/various/nginx-configuration-guide/#:~:text=Every%20NGINX%20configuration%20file%20will,interchangeably%20as%20blocks%20or%20contexts%20.)

Every NGINX configuration file will be found in the /etc/nginx/ directory, with the main configuration file located in /etc/nginx/nginx.conf .

NGINX configuration options are known as “directives”: these are arranged into groups, known interchangeably as blocks or contexts .
Lines that contain directives should end with a semicolon (;). If not, NGINX will be unable to load the configuration properly and report an error.

* Http block

```
http {

...

}
```
The http block includes directives for web traffic handling, which are generally known as universal . That’s because they get passed on to each website configuration served by NGINX.

* Server blocks

```
server {

...

}
```

When installing NGINX from the Ubuntu or Debian repositories, the line will read: include /etc/nginx/sites-enabled/;. The ../sites-enabled/ folder will include symlinks to the site configuration files located within /etc/nginx/sites-available/. You can disable sites within sites-available if you take out the symlink to sites-enabled. An illustrative configuration file can be found at /etc/nginx/conf.d/default.conf or etc/nginx/sites-enabled/default.

* Listening Ports

The listen directive informs NGINX of the hostname/IP and TCP port, so it recognizes where it must listen for HTTP connections.

* Name-based Virtual Hosting

The server_name directive enables a number of domains to be served from just one IP address, and the server will determine which domain it will serve according to the request header received.

Generally, you should create one file for each site or domain you wish to host on your server.

The server_name directive can utilize wildcards. `*`.example.com and .example.com tell the server to process requests for all example.com subdomains

File `/etc/nginx/conf.d/example.com.conf`:

```
server_name *.example.com;

server_name .example.com;

server_name example.*;
```

* Location Blocks

NGINX’s location setting helps you set up the way in which NGINX responds to requests for resources inside the server. As the server_name directive informs NGINX how it should process requests for the domain, location directives apply to requests for certain folders and files (e.g. http://example.com/blog/) 

File `/etc/nginx/sites-available/example.com`

```
location / { }

location /images/ { }

location /blog/ { }

location /planet/ { }

location /planet/blog/ { }
```
* How to Use Location Root and Index

```
location / {

root html;

index index.html index.htm;

}
```

In the example, the document root is based in the html/ directory. Under the NGINX default installation prefix, the location’s full path is /etc/nginx/html/
 
The `index` variable informs NGINX which file it should serve when or if none are specified.

## Defining_Environment_Variables

from [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose)

Your database and WordPress application containers will need access to certain environment variables at runtime in order for your application data to persist and be accessible to your application. These variables include both sensitive and non-sensitive information: sensitive values for your DB root password and application database user and password, and non-sensitive information for your application database name and host.

Rather than setting all of these values in our Docker Compose file — the main file that contains information about how our containers will run — we can set the sensitive values in an .env file and restrict its circulation. This will prevent these values from copying over to our project repositories and being exposed publicly.

## mysql

| Browsing|
|-----------------|
| `SHOW DATABASES;`|
|`SHOW TABLES FROM database;`|
|`DESCRIBE table;`|
|             |

|Select|
|------|
| `SELECT * FROM table;`|
| `SELECT * FROM table1, table2;`|
| `SELECT field1, field2 FROM table1, table2;`|
| `SELECT ... FROM ... WHERE condition`|
| `SELECT ... FROM ... WHERE condition GROUP BY field;`|
| `SELECT ... FROM ... WHERE condition GROUP BY field HAVING condition2;`|
| `SELECT ... FROM ... WHERE condition ORDER BY field1, field2;`|
| `SELECT ... FROM ... WHERE condition ORDER BY field1, field2 DESC;`|
| `SELECT ... FROM ... WHERE condition LIMIT 10;`|
| `SELECT DISTINCT field1 FROM ...;`|
| `SELECT DISTINCT field1, field2 FROM ...;`|
|                                      |

|Create / Open / Delete Database|
|------------------------------|
|`CREATE DATABASE DatabaseName;`|
|`CREATE DATABASE DatabaseName CHARACTER SET utf8;`|
|`USE DatabaseName;`|
|`DROP DATABASE DatabaseName;`|
|`ALTER DATABASE DatabaseName CHARACTER SET utf8;`|
|                                            |

|Users and Privileges|
|---------------------|
|`CREATE USER 'user'@'localhost';`|
|`GRANT ALL PRIVILEGES ON base.* TO 'user'@'localhost' IDENTIFIED BY 'password';`|
|`GRANT SELECT, INSERT, DELETE ON base.* TO 'user'@'localhost' IDENTIFIED BY 'password';`|
|`REVOKE ALL PRIVILEGES ON base.* FROM 'user'@'host';` -- one permission only|
|`REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'user'@'host';` -- all permissions|
|`FLUSH PRIVILEGES;`|
|                |

## How to export a database 

`mysqldump -u user -p database_name > file.sql`

## How to copy files to/from a container

**from the local file sistem to a container**
`docker cp <src-path> <container>:<dest-path>`

**from the container to the local file system**
`docker cp <container>:<src-path> <local-dest-path>`

More at [MySQL cheatsheet](https://devhints.io/mysql)

## Socket

A socket is a communication endpoint to which an application can write data (to be sent to the underlying network) and from which an application can read data. The process/application can be related or unrelated and may be executing on the same or different machines

![image](https://user-images.githubusercontent.com/63563271/168162259-d215ce73-896d-4b55-97d2-53adf018e369.png)


## study_resources

* [Docker And Containers Explained](https://www.youtube.com/watch?v=A0g7I4A6GN4)
* [the importance of pid 1 in containers](https://tandrepires.wordpress.com/2016/11/15/the-importance-of-pid-1-in-containers/)
* [difference between nginx daemon on off option](https://stackoverflow.com/questions/25970711/what-is-the-difference-between-nginx-daemon-on-off-option#:~:text=For%20Docker%20containers%20(or%20for%20debugging)%2C%20the%20daemon%20off%3B%20directive%20tells%20Nginx%20to%20stay%20in%20the%20foreground.%20For%20containers%20this%20is%20useful%20as%20best%20practice%20is%20for%20one%20container%20%3D%20one%20process.%20One%20server%20(container)%20has%20only%20one%20service.)
* [difference between cmd and entrypoint in a dockerfile](https://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile)
* [digital ocean- how to install wordpress with docker compose](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose)
* [Lec34 Socket Programming Part-I](https://www.youtube.com/watch?v=tk_RpIVbOMQ&list=PL7B2bn3G_wfC-mRpG7cxJMnGWdPAQTViW&index=34)
* [How To Import and Export Databases in MySQL or MariaDB](https://www.digitalocean.com/community/tutorials/how-to-import-and-export-databases-in-mysql-or-mariadb)
* [Volume documentation docker](https://docs.docker.com/storage/volumes/)
* [How to create docker volume device/host path Stackoverflow thread](https://stackoverflow.com/questions/49950326/how-to-create-docker-volume-device-host-path)
