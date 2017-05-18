#!/bin/bash
set -e

HOST_NAME=localhost
INSTALL_BASE=/opt
YUM_UPDATE=true

LOCAL_REPO=$INSTALL_BASE/repository

function ensure_mandatory_variables_set {
  for var in HOST_NAME INSTALL_BASE YUM_UPDATE; do
    if [ ! -n "${!var:-}" ]; then
      echo "Variable '$var' is not set! Set this in `basename $0`"
      exit 1
    fi
  done

  if [ $YUM_UPDATE != "true" ] && [ $YUM_UPDATE != "false" ]
  then
     echo "Variable YUM_UPDATE must be either true or false"
     exit 1
  fi
}

function ensure_install_base_exists {
  if [ ! -d "$INSTALL_BASE" ]; then
    echo "The directory $INSTALL_BASE where you have requested the install"
    echo "to occur does not exist."
    exit 1
  fi
}

function install_yum_dependencies {
  if [ $YUM_UPDATE == "true" ]
  then
    yum -y update
  else
    count_updates=`yum check-update --quiet | grep '^[a-Z0-9]' | wc -l`

    echo "WARNING: Automatic server software updates performed by this"
    echo "         installer have been disabled!"
    echo ""
    if (( $count_updates == 0 ))
    then
        echo "There are no patches or updates that are currently outstanding" \
             "for this server,"
        echo "however we recommend that you patch your server software" \
             "regularly!"
    else
        echo "There are currently $count_updates patches or update that are" \
             "outstanding on this server"
        echo "Use 'yum update' to update to following software!"
	echo ""

        yum list updates --quiet

        echo ""
        echo "We recommend that you patch your server software regularly!"
    fi
  fi
  echo "Install git"
  yum -y -q -e0 install git

  echo ""
  echo "Install ansible"
  yum -y -q -e0 install ansible
}

function pull_repo {
  pushd $LOCAL_REPO > /dev/null
  git pull
  popd > /dev/null
}

function run_ansible {
  ansible-playbook -i 'localhost ansible_connection=local,' create_users.yml
}

function display_completion_message {
  cat << EOF

Bootstrap finished!

EOF
}

function bootstrap {
  ensure_mandatory_variables_set
  ensure_install_base_exists
  install_yum_dependencies
  run_ansible
  display_completion_message
}

bootstrap
