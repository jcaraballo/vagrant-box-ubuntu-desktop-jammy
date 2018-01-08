#!/bin/bash

apt-get update

apt-get -y remove unattended-upgrades

apt-get -y upgrade

apt-get -y install vim

echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

apt-get -y install openssh-server

