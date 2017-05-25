#!/bin/bash
set -e

sudo yum -y install ansible
sudo yum -y install git
sudo git clone https://github.com/juliankelly24/ansible ~/ansible
sudo ansible-playbook -i 'localhost ansible_connection=local,' ~/ansible/create_users.yml
