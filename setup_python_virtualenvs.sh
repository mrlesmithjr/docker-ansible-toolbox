#!/usr/bin/env bash
set -x

ANSIBLE_VERSIONS=("1.9.4" "1.9.5" "1.9.6" "2.0.0.0" "2.0.0.1" "2.0.0.2" \
    "2.0.1.0" "2.0.2.0" "2.1.0.0" "2.1.1.0" "2.1.2.0" \
    "2.1.3.0" "2.1.4.0" "2.1.5.0" "2.1.6.0" "2.2.0.0" "2.2.1.0" \
    "2.2.2.0" "2.2.3.0" "2.3.0.0" "2.3.1.0" "2.3.2.0" "2.3.3.0" \
  "2.4.0.0" "2.4.1.0" "2.4.2.0")
VIRTUALENV_PATH="/home/ansible/python-virtualenvs"

for ANSVER in "${ANSIBLE_VERSIONS[@]}"
do
  virtualenv $VIRTUALENV_PATH/ansible-$ANSVER
  source $VIRTUALENV_PATH/ansible-$ANSVER/bin/activate
  pip install ansible==$ANSVER
  deactivate
done
