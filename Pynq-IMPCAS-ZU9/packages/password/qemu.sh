#!/bin/bash
echo "xilinx:${PYNQ_PSWD:-"xilinx"}" | chpasswd
echo "root:${PYNQ_PSWD:-"xilinx"}" | chpasswd
echo "${PYNQ_PSWD:-"xilinx"}" | smbpasswd -a xilinx
