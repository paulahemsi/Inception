# Inception
 System Administration Exercise :whale:

* [diagram](#diagram)
* [folder_structure](#folder_structure)
* [dockerfile](#dockerfile)

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


## containers vs virtual machines

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
