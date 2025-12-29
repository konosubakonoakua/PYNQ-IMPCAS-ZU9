#!/bin/bash
# Use PYNQ_BOARD to set hostname
if [ -n "$PYNQ_BOARD" ]; then
	pynq_hostname.sh $PYNQ_BOARD
else
	pynq_hostname.sh Pynq-IMPCAS-ZU9
fi
