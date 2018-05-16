############################################################
# Dockerfile for Ansible and Terraform
# Based on Fedora 28
############################################################

# Set the base image to Fedora 28
FROM fedora:28

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

# Copy password file used to decrypt secrets using Ansible Vault
COPY .password.txt /root/.password.txt
RUN chmod -x /root/.password.txt

# Setup SSH keys and config
COPY SSH /root/.ssh
# Decrypt SSH secrets
RUN ansible-vault decrypt /root/.ssh/authorized_keys --vault-password-file ~/.password.txt
RUN ansible-vault decrypt /root/.ssh/insecure_private_key --vault-password-file ~/.password.txt

# Set permissions for SSH key directory
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
RUN chmod 400 /root/.ssh/*

# Setup OpenStack CLI

COPY OPENSTACK /root/.config/openstack/
# Decrypt OpenStack secrets
RUN ansible-vault decrypt /root/.config/openstack/clouds.yaml --vault-password-file ~/.password.txt
RUN ansible-vault decrypt /root/.config/openstack/secure.yaml --vault-password-file ~/.password.txt

# Setup Ansible host inventory
COPY HOSTS /etc/ansible
# Decrypt Ansible secrets
RUN ansible-vault decrypt /etc/ansible/hosts --vault-password-file ~/.password.txt

# Setup Ansible global group_vars
COPY GROUP_VARS /etc/ansible/group_vars/
# Decrypt Ansible secrets
RUN ansible-vault decrypt /etc/ansible/group_vars/example --vault-password-file ~/.password.txt

# Setup Ansible host_vars
COPY HOST_VARS /etc/ansible/host_vars/
# Decrypt Ansible secrets
RUN ansible-vault decrypt /etc/ansible/host_vars/example --vault-password-file ~/.password.txt
