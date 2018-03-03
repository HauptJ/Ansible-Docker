# Ansible-Docker

[![Build Status](https://travis-ci.org/HauptJ/Ansible-Docker.svg?branch=master)](https://travis-ci.org/HauptJ/Ansible-Docker)

Ansible in Docker, fully compatible with Docker for Windows

Before we begin please note *the `<>` just indicate values you need to replace with your own. Do not use `<` or `>` in your commands.*

Included packages:
------------------

emacs
vim
nano
git
python2
python3
python-pip
wget
curl
net-tools
iputils
sshpass
ansible
pywinrm

To pre load SSH keys, and inventory files:
------------------------------------------
You can load your SSH private keys files by placing them in the `SSH` directory.
You can load your Ansible `hosts` inventory file by placing it in the `HOSTS` directory.
You can load your `group_vars` inventory files by placing them in the `GROUP_VARS` directory.
You can load your `host_vars` inventory files by placing them in the `HOST_VARS` directory.



To build the container:
-----------------------

```
docker build -t <image tag>:<image version number> .
```

The image tag and version number can be anything you want. For example, if you want to use: 
`ansible:latest`, your build command would be: `docker build -t ansible:latest . `


To run the container:
---------------------

```
docker run -i -t --name <container name> -h <container hostname> -v <host directory>:<container directory> <image tag>:<image version number> /bin/bash
```

*NOTE:* If you are using Docker on Windows, you will have to use UNIX style `/` instead of \ to specify the host directory. For example:
`c:/Users/hauptj/Docker/ansible/volumes`

Pre-built container:
--------------------

You can download a pre-built version of this container from the public Docker repository by running:

`docker pull hauptj/ansible-fedora-27`
