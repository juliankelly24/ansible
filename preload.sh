#!/bin/bash
set -e

REPO=/opt/aaf/repo

curl https://raw.githubusercontent.com/juliankelly24/ansible/master/config.sh > $REPO/config.sh
chmod +x $REPO/config.sh
$REPO/config.sh
