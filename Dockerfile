############################################################
# Dockerfile for Ansible
# Based on Fedora 27
############################################################

# Set the base image to Fedora 27
FROM fedora:27

# File Author / Maintainer
MAINTAINER josh@hauptj.com

################## Begin Installation ######################

# Update the repository sources list 
RUN dnf upgrade -y

# Install packages

RUN dnf install -y \
	emacs \
	vim \
	nano \
	git \
	python2 \
	python3 \
	python-pip \
	wget \
	curl \
	net-tools \
	iputils \
	sshpass
	
# Install Ansible and PYWINRM (Python Windows Remote Management)

RUN pip install \
	ansible \
	pywinrm
	
# Setup SSH keys config

COPY SSH ~/.ssh

# Setup Ansible host inventory

COPY HOSTS /etc/ansible
	
# Setup Ansible global group_vars

COPY GROUP_VARS /etc/ansible/group_vars/

# Setup Ansible host_vars

COPY HOST_VARS /etc/ansible/host_vars/