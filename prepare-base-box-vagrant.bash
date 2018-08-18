#!/bin/bash

mkdir -p ~/.ssh \
&& chmod 700 ~/.ssh \
&& wget -O - https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub >> ~/.ssh/authorized_keys \
&& chmod 644 ~/.ssh/authorized_keys

