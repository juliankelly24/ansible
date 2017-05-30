#!/bin/bash
set -e

REPO=/opt/aaf/repo
CRON_REPO=/opt/aaf/x
REPO_NAME=https://github.com/juliankelly24/ansible
SSH=/home/ec2-user/.ssh/authorized_keys

JULIAN=/opt/aaf/repo/pub_keys/julian.pub
TERRY=/opt/aaf/repo/pub_keys/terry.pub
DALIA=/opt/aaf/repo/pub_keys/dalia.pub
MELROY=/opt/aaf/repo/pub_keys/melroy.pub

yum -y install epel-release
yum -y install ansible git

if [[ ! -e $REPO ]]; then
    git clone $REPO_NAME $REPO
elif [[ ! -d $dir ]]; then
     1>&2
fi

cd /opt/aaf/repo
git reset --hard
git pull

if [[ ! -e $CRON_REPO ]]; then
    mkdir /opt/aaf/x
elif [[ ! -d $dir ]]; then
     1>&2
fi

cp -f /opt/aaf/repo/config.sh /opt/aaf/x/cron.sh
chmod +x $CRON_REPO/cron.sh

if cmp -s "$JULIAN" "$SSH"
then
  echo "* * * * * /bin/sh /opt/aaf/x/cron.sh | mail -s 'errors' julian.kelly@aaf.edu.au" > /var/spool/cron/root
  echo "Hello Julian :)"
fi
if cmp -s "$TERRY" "$SSH"
then
  echo "30 1 * * * /bin/sh /opt/aaf/x/cron.sh | mail -s 'errors' t.smith@aaf.edu.au" > /var/spool/cron/root
  echo "Hello Terry :)"
fi
if cmp -s "$DALIA" "$SSH"
then
  echo "30 1 * * * /bin/sh /opt/aaf/x/cron.sh | mail -s 'errors' dalia.abraham@aaf.edu.au" > /var/spool/cron/root
  echo "Hello Dalia :)"
fi
if cmp -s "$MELROY" "$SSH"
then
  echo "30 1 * * * /bin/sh /opt/aaf/x/cron.sh | mail -s 'errors' melroy.almeida@aaf.edu.au" > /var/spool/cron/root
  echo "Hello Melroy :)"
fi

ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
