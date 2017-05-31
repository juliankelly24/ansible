#!/bin/bash
set -e

# File Locations
REPO=/opt/aaf/repo
REPO_NAME=https://github.com/juliankelly24/ansible

# Installs Dependencies Epel & Ansible
yum -y install epel-release
yum -y install ansible git

# Clones Repo if Directory does not exist
if [[ ! -e $REPO ]]; then
    git clone $REPO_NAME $REPO
elif [[ ! -d $dir ]]; then
     1>&2
fi

# Clears changes pulls updated repo master branch
cd /opt/aaf/repo
git reset --hard
git pull

#Compares files to EC2-USER Public Key for Cron Issue Email Schedule
if cmp -s "$JULIAN" "$SSH"
then
  echo "30 * * * * /bin/sh /opt/aaf/x/cron.sh | mail -s 'errors' julian.kelly@aaf.edu.au" > /var/spool/cron/root
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

# Run Ansible Playbook with Yum Update
ansible-playbook -i 'localhost ansible_connection=local,' $REPO/create_users.yml
