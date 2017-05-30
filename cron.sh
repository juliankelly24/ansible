#!/bin/bash
set -e

REPO=/opt/aaf/repo
REPO_NAME=https://github.com/juliankelly24/ansible

rm -rf $REPO
git clone $REPO_NAME $REPO
ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
