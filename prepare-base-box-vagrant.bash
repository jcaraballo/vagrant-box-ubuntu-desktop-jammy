#!/bin/bash

mkdir ~/.ssh
chmod 700 ~/.ssh
wget -O - ~/.ssh/authorized_keys >> https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub
chmod 644 ~/.ssh/authorized_keys

