#!/bin/bash

set -e

sudo apt update
sudo apt full-upgrade

#echo "Start update-atom script..."
#update-atom.sh

#if echo $PATH | grep cargo &> /dev/null; then
#    echo "Start cargo update foo..."
#    cargo install-update -a
#fi

#if echo $PATH | grep -i go &> /dev/null; then
#    echo "Start go get..."
#    go get -u all
#fi

#apm upgrade
