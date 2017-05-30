#!/bin/bash
set -e

REPO=/opt/aaf/repo
REPO_NAME=https://github.com/juliankelly24/ansible

yum -y install epel-release
yum -y install ansible git

if [[ ! -e $REPO ]]; then
    git clone $REPO_NAME $REPO
elif [[ ! -d $dir ]]; then
    echo "Git Pull" 1>&2
fi

cd /opt/aaf/repo
git reset --hard
git pull 
ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
mkdir /opt/aaf/x
cp -f /opt/aaf/repo/config.sh /opt/aaf/x/cron.sh
chmod +x $REPO/cron.sh
echo "30 1 * * * /bin/sh /opt/aaf/x/cron.sh > /root/cronlog" > /var/spool/cron/root
