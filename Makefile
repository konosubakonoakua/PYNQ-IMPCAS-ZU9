# Copyright (C) 2022 Xilinx, Inc
# Copyright (c) 2022-2025, Advanced Micro Devices, Inc.

# SPDX-License-Identifier: BSD-3-Clause

ROOT_PATH := $(abspath $(dir $(firstword $(MAKEFILE_LIST))))

BOARD_NAME ?= Pynq-IMPCAS-ZU9

PREBUILT_IMAGE := ${ROOT_PATH}/pynq/sdbuild/prebuilt/pynq_rootfs.aarch64.tar.gz
PREBUILT_SDIST := ${ROOT_PATH}/pynq/sdbuild/prebuilt/pynq_sdist.tar.gz
XSA_FILE := ${ROOT_PATH}/${BOARD_NAME}/base/base.xsa

all: gitsubmodule base image
	echo ${ROOT_PATH}

# INFO: By default: PYNQ_SDIST=${PREBUILT_SDIST} PYNQ_ROOTFS=${PREBUILT_IMAGE}
image: gitsubmodule ${PREBUILT_SDIST} ${PREBUILT_IMAGE}
	cd ${ROOT_PATH}/pynq/sdbuild/ && make BOARDDIR=${ROOT_PATH}/ BOARDS=${BOARD_NAME}

base: ${BOARD_FILES} check-xsa
	@echo "XSA file verification passed for ${BOARD_NAME}"

check-xsa:
	@if [ ! -f "$(XSA_FILE)" ]; then \
		echo "Error: XSA file does not exist: $(XSA_FILE)"; \
		echo "The XSA file should exist by default for board ${BOARD_NAME}. Please check:"; \
		echo "1. If the hardware project has been built successfully"; \
		echo "2. If the BOARD_NAME variable is set correctly"; \
		echo "3. If the Vivado project has been exported properly"; \
		exit 1; \
	fi
	@echo "XSA file exists for ${BOARD_NAME}: $(XSA_FILE)"

# ${XSA_FILE}: check-xsa
# 	cd ${ROOT_PATH}/${BOARD_NAME}/base && make

gitsubmodule:
	@echo "Updating submodule"
	git submodule init && git submodule update

${PREBUILT_IMAGE}:
	wget https://download.amd.com/opendownload/pynq/jammy.aarch64.3.1.0.tar.gz -O $@
	@echo "Got $@"

${PREBUILT_SDIST}:
	wget https://download.amd.com/opendownload/pynq/pynq-3.1.2.tar.gz -O $@
	@echo "Got $@"

cleanbuild:
	sudo make -C pynq/sdbuild/ clean

.PHONY: check-xsa base all image cleanbuild gitsubmodule
