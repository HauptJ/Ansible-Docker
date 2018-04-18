############################################################
# Dockerfile for Ansible and Terraform
# Based on Fedora 27
############################################################

# Set the base image to Fedora 27
FROM fedora:27

# File Author / Maintainer
MAINTAINER josh@hauptj.com


################## Environment Variables ###################

# Terraform Version
ENV TERRAFORM_VERSION=0.11.7

################## Begin Installation ######################

# Update the repository sources list
RUN dnf upgrade -y

# Install packages
RUN dnf install -y \
	gcc \
	emacs \
	vim \
	nano \
	git \
	python2 \
	python3 \
	python-pip \
	python-devel \
	wget \
	curl \
	net-tools \
	iputils \
	sshpass \
	openssl \
	unzip

# Upgrade to the latest version of pip
RUN pip install --upgrade pip

# Install Ansible and PYWINRM (Python Windows Remote Management), and OpenStack CLI
RUN pip install \
	ansible \
	pywinrm \
	setuptools \
	python-openstackclient

# Install Terraform
RUN cd /tmp && \
	wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin

# Copy password file used to decrypt secrets
COPY .password.txt /root/.password.txt

# Setup SSH keys and config
COPY SSH /root/.ssh

# Set permissions for SSH key directory
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
RUN chmod 400 /root/.ssh/*

# Setup OpenStack CLI

COPY OPENSTACK /root/.config/openstack/

# Setup Ansible host inventory
COPY HOSTS /etc/ansible

# Setup Ansible global group_vars
COPY GROUP_VARS /etc/ansible/group_vars/

# Setup Ansible host_vars
COPY HOST_VARS /etc/ansible/host_vars/
