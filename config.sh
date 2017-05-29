#!/bin/bash
set -e

REPO=/opt/aaf/repo

yum -y install epel-release 
yum -y install ansible git
git clone https://github.com/juliankelly24/ansible $REPO
ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
