#!/bin/bash
set -e

REPO=/opt/aaf/repo
REPO_NAME=https://github.com/juliankelly24/ansible
CRON_REPO=/opt/aaf/x

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


if [[ ! -e $CRON_REPO ]]; then
    mkdir /opt/aaf/x
elif [[ ! -d $dir ]]; then
    echo "CRON REPO ALREADY EXISTS" 1>&2
fi

cp -f /opt/aaf/repo/config.sh /opt/aaf/x/cron.sh
chmod +x $CRON_REPO/cron.sh
echo "30 1 * * * /bin/sh /opt/aaf/x/cron.sh > /root/cronlog" > /var/spool/cron/root
