#!/bin/bash
set -e

yum -y install epel-release 
yum -y install ansible git
git clone https://github.com/juliankelly24/ansible /opt/aaf/repo
ansible-playbook -i 'localhost ansible_connection=local,' /opt/aaf/repo/create_users.yml
