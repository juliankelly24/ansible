#!/bin/bash
set -e

REPO=/opt/aaf/repo
REPO_NAME=https://github.com/juliankelly24/ansible

ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
