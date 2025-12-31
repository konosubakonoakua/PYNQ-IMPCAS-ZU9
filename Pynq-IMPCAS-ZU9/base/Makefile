# Copyright (C) 2022 Xilinx, Inc
# SPDX-License-Identifier: BSD-3-Clause

overlay_name := base
design_name := base

all: xsa
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

xsa:
	unzip -q -o $(overlay_name).xsa
	mv $(overlay_name)_wrapper.bit $(overlay_name).bit
	rm -f psu_init* xsa.* *.xml *.bda

clean:
	rm -rf *.json *.c *.html *.xml *.hwh *.tcl *.bit *.h *.bda

.PHONY: all xsa clean
