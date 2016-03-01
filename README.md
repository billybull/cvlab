# OpenCV and Nodejs Lab

A simple lab environment which makes calls to OpenCV using Nodejs and serves up and displays data with Express-handlebars. Provisioning done with Docker Machine. Requires: Git and Docker Toolbox (Docker Machine, Virtualbox) to be installed.

## Quick Start

#### Install Docker Toolbox and Git. Make sure virtualization is enabled on your computer.

https://docs.docker.com/machine/install-machine/
https://git-scm.com/book/en/v2/Getting-Started-Installing-Git


#### Navigate to the directory of your choice and clone the repository into it.
```bash
git clone https://github.com/wcbullington/cvlab .
cd cvlab
```
#### Start a docker host. Assumes you have no default host yet set-up and you are using virtualbox
```bash
docker-machine create --driver virtualbox default
```
#### Connect your shell to the docker host machine
```bash
docker-machine env
```

Then run the command displayed at the end of the output.

#### Make sure you are logged in to Docker.
```bash
docker login
```

... and give your login information.

#### Run the container in the docker host machine
```bash
docker run wcbullington/cvlab
```
#### Then visit:

```
http://192.168.10.10:8080/
```
