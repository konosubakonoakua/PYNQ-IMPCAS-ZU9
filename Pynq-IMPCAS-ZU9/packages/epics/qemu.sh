#!/bin/bash

set -e
set -x

. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

export HOME=/root
export BOARD=${PYNQ_BOARD}

# PROXY_HOST=192.168.138.254
# PROXY_PORT=7897
# PROXY_URL="http://${PROXY_HOST}:${PROXY_PORT}"
# export http_proxy=$PROXY_URL
# export https_proxy=$PROXY_URL
# export HTTP_PROXY=$PROXY_URL
# export HTTPS_PROXY=$PROXY_URL
# git config --global http.proxy $PROXY_URL
# git config --global https.proxy $PROXY_URL

mkdir -p /opt/epics
chown xilinx:xilinx /opt/epics
cd /opt/epics
git clone --recursive -b 7.0 https://github.com/epics-base/epics-base.git base-7.0
chown -R xilinx:xilinx base-7.0

# git config --global --unset http.proxy
# git config --global --unset https.proxy
