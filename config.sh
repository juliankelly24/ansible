#!/bin/bash
set -e

REPO=/opt/aaf/repo
REPO_NAME=https://github.com/juliankelly24/ansible

yum -y install epel-release 
yum -y install ansible git
git clone $REPO_NAME $REPO
ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
echo "30 2 * * * root /opt/aaf/repo/cron.sh" > /var/spool/cron/root
