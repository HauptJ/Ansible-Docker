# Ansible-Docker

[![Build Status](https://travis-ci.org/HauptJ/Ansible-Docker.svg?branch=master)](https://travis-ci.org/HauptJ/Ansible-Docker)

Ansible, Terraform and OpenStack CLI in Docker
Fully compatible with Docker for Windows

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

To pre load SSH keys, inventory files, and OpenStack:
------------------------------------------
You can load your SSH private keys files by placing them in the `SSH` directory.
**NOTE:** Vagrant's insecure_private_key is included for provisioning vagrant boxes.
You can load your Ansible `hosts` inventory file by placing it in the `HOSTS` directory.
You can load your `group_vars` inventory files by placing them in the `GROUP_VARS` directory.
You can load your `host_vars` inventory files by placing them in the `HOST_VARS` directory.
You can load your OpenStack account `clouds.yaml` and OpenStack account secrets file `secure.yaml` by placing them in the `OPENSTACK` directory.
[Instructions to configure the OpenStack CLI](http://docs.platform9.com/support/managing-multiple-clouds-openstack-cli/)

**NOTE:** You can use [Ansible Vault](https://docs.ansible.com/ansible/2.5/user_guide/vault.html) to encrypt and decrypt files containing secrets.

- Ansible Vault is included with Ansible. To install the latest version of Ansible on Ubuntu 16.04 / Linux Subsystem for Windows:
```
sudo apt update && sudo apt -y upgrade && sudo apt -y install software-properties-common && sudo apt-add-repository ppa:ansible/ansible && sudo apt -y update && sudo apt -y install ansible && ansible --version
```

- In the `Dockerfile`, the password file is: `.password.txt`

- To encrypt a file
```
ansible-vault encrypt <path to file> --vault-password-file <path to password file>
```
- To decrypt a file
```
ansible-vault decrypt <path to file> --vault-password-file <path to password file>
```


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

**NOTE:** If you are using Docker on Windows, you will have to use UNIX style `/` instead of \ to specify the host directory. For example:
`c:/Users/hauptj/Docker/ansible/volumes`

**NOTE:** You can mount your current working directory using the cross platform `${PWD}` variable. For example:
```
docker run -i -t --name ansible -h ansible -v ${PWD}:/data ansible:latest /bin/bash
```
SEE: [Mount current directory as volume in Docker on Windows 10](https://stackoverflow.com/questions/41485217/mount-current-directory-as-volume-in-docker-on-windows-10)

Pre-built container:
--------------------

You can download a pre-built version of this container from the public Docker repository by running:

`docker pull hauptj/ansible-terraform`
