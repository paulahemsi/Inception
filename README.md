# Inception
 System Administration Exercise :whale:

* [diagram](#diagram)
* [folder_structure](#folder_structure)
* [containers](#containers)
* [containers_vs_virtual_machines](#containers_vs_virtual_machines)
* [dockerfile](#dockerfile)
* [docker_image](#docker_image)
* [docker_compose](#docker_compose)
* [study_resources](#study_resources)

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


## containers_vs_virtual_machines

![image](https://user-images.githubusercontent.com/63563271/165406602-7fdf7260-5f29-448f-82a1-82bb8030817c.png)
from [docker](https://www.docker.com/resources/what-container/)



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

## docker_image

A docker image ia a template of instructions that are used to create containers.
A docker image is built using the dockerfile.

## docker_compose

A docker compose is used for running multiple containers as a single service. In compose service, each container runs in isolarion but can interact with each other with no limitations 

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

## docker CLI commands

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




more in [The Ultimate Docker Cheat Sheet](https://dockerlabs.collabnix.com/docker/cheatsheet/) and[docker-compose-cheatsheet](https://jonlabelle.com/snippets/view/markdown/docker-compose-cheatsheet)










## study_resources

* [Docker And Containers Explained](https://www.youtube.com/watch?v=A0g7I4A6GN4)
