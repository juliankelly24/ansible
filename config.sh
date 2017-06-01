#!/bin/bash
set -e

# File Locations
REPO=/opt/aaf/repo
REPO_NAME=https://github.com/juliankelly24/ansible

# Installs Dependencies Epel & Ansible
yum -y install epel-release
yum -y install ansible git

# Clones Repo if Directory does not exist
if [[ ! -e $REPO ]]; then
    git clone $REPO_NAME $REPO
elif [[ ! -d $dir ]]; then
     1>&2
fi

# Clears changes pulls updated repo master branch
cd /opt/aaf/repo
git reset --hard
git pull

# Run Ansible Playbook with Yum Update
ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
