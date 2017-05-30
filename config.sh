#!/bin/bash
set -e

REPO=/opt/aaf/repo
CRON_REPO=/opt/aaf/x
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

if [[ ! -e $CRON_REPO ]]; then
    mkdir /opt/aaf/x
elif [[ ! -d $dir ]]; then
    echo "CRON REPO ALREADY EXISTS" 1>&2
fi

cp -f /opt/aaf/repo/config.sh /opt/aaf/x/cron.sh
chmod +x $CRON_REPO/cron.sh

# Julian Key
if [[ 'grep 'foZTeaSLx5 Generated-by-Nova' /home/ec2-user/.ssh/authorized_keys' ]];then
   echo "* * * * * /bin/sh /opt/aaf/x/cron.sh | mail -s "errors" julian.kelly@aaf.edu.au" > /var/spool/cron/root
# Terry Key
elif [[ 'grep 'h91g+odh6l New Laptop' /home/ec2-user/.ssh/authorized_keys' ]];then
  echo "30 1 * * * /bin/sh /opt/aaf/x/cron.sh | mail -s "errors" t.smith@aaf.edu.au" > /var/spool/cron/root
# Dalia Key
elif [[ 'grep 'bftCRfsG5B daliaabraham@Dalias-MacBook-Pro.local' /home/ec2-user/.ssh/authorized_keys' ]];then
  echo "30 1 * * * /bin/sh /opt/aaf/x/cron.sh | mail -s "errors" dalia.abraham@aaf.edu.au" > /var/spool/cron/root
# Melroy Key
elif [[ 'grep '9uNr4oVSFr melroy.almeida@aaf.edu.au' /home/ec2-user/.ssh/authorized_keys' ]];then
  echo "30 1 * * * /bin/sh /opt/aaf/x/cron.sh | mail -s "errors" melroy.almeida@aaf.edu.au" > /var/spool/cron/root
 fi

ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
