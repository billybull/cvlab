# OpenCV and Nodejs Lab

A simple lab environment which makes calls to OpenCV using Nodejs and serves up and displays data with Express-handlebars. Provisioning done with Vagrant and Docker.

## Quick Start

Download and install Vagrant: https://www.yagrantup.com/downloads.html

Download and install Virtualbox: https://www.virtualbox.org/wiki/Downloads


Then open a terminal and navigate to where you would like to clone the repository. Execute the following commands:

```bash
git clone https://github.com/wcbullington/cvlab .
cd cvlab
vagrant up --provider=docker
```

At password prompts use "tcuser".

Then visit:

```
http://192.168.10.10:8080/
```
