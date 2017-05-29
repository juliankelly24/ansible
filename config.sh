#!/bin/bash
set -e

yum -y install ansible git
git clone https://github.com/juliankelly24/ansible ~/ansible
ansible-playbook -i 'localhost ansible_connection=local,' ~/ansible/create_users.yml
