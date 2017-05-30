#!/bin/bash
set -e

REPO=/opt/aaf/cron
REPO_NAME=https://github.com/juliankelly24/ansible

git clone $REPO_NAME $REPO
ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
rm -rf $REPO
