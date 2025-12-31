#!/bin/bash

set -e
set -x

. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

export HOME=/root
export BOARD=${PYNQ_BOARD}

# export http_proxy=http://192.168.138.254:7897
# export https_proxy=http://192.168.138.254:7897

mkdir -p /opt/epics
chown xilinx:xilinx /opt/epics
cd /opt/epics
git clone --recursive -b 7.0 https://github.com/epics-base/epics-base.git base-7.0
chown -R xilinx:xilinx base-7.0
