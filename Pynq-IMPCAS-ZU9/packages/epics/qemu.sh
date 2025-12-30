#!/bin/bash

sudo mkdir -p /opt/epics
sudo chown xilinx:xilinx /opt/epics
cd /opt/epics
git clone --recursive -b 7.0 https://github.com/epics-base/epics-base.git base-7.0
