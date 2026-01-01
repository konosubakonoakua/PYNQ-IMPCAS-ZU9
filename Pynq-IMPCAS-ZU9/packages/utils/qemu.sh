#!/bin/bash

set -e
set -x

. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

export HOME=/home/xilinx

# PROXY_HOST=192.168.138.254
# PROXY_PORT=7897
# PROXY_URL="http://${PROXY_HOST}:${PROXY_PORT}"
# export http_proxy=$PROXY_URL
# export https_proxy=$PROXY_URL
# export HTTP_PROXY=$PROXY_URL
# export HTTPS_PROXY=$PROXY_URL
# git config --global http.proxy $PROXY_URL
# git config --global https.proxy $PROXY_URL

# INFO: don't add sudo
apt install -y \
	ripgrep smbclient avahi-utils btop iotop sysstat strace ltrace \
	u-boot-tools tio net-tools minicom libtool \
	cmake autoconf automake gdb-multiarch gdbserver valgrind ninja-build \
	git-lfs screen xterm gawk xz-utils util-linux

apt install -y bc bison flex libssl-dev libelf-dev libncurses-dev libfdt-dev

# Git clone with retry function
git_clone_with_retry() {
	local repo_url=$1
	local target_dir=$2
	local max_retries=${3:-2} # Default to 2 retries if not specified
	local attempt=1

	while [ $attempt -le $((max_retries + 1)) ]; do
		echo "Attempting git clone (attempt $attempt of $((max_retries + 1)))..."

		if git clone --depth 1 "$repo_url" "$target_dir"; then
			echo "Git clone successful on attempt $attempt"
			return 0
		else
			echo "Git clone failed on attempt $attempt"
			if [ -d "$target_dir" ]; then
				echo "Cleaning up failed clone directory..."
				rm -rf "$target_dir"
			fi

			if [ $attempt -le $max_retries ]; then
				local wait_time=$((attempt * 5))
				echo "Waiting ${wait_time} seconds before retry..."
				sleep $wait_time
			fi
			attempt=$((attempt + 1))
		fi
	done

	echo "Error: Git clone failed after $((max_retries + 1)) attempts"
	return 1
}

cd /home/xilinx
mkdir -p /home/xilinx/.local/bin

# Use the retry function for git clone
git_clone_with_retry https://github.com/junegunn/fzf.git .fzf
/home/xilinx/.fzf/install --all

wget -qO- https://github.com/zellij-org/zellij/releases/latest/download/zellij-aarch64-unknown-linux-musl.tar.gz |
	tar -xzf - -C /usr/local/bin/ zellij && chmod +x /usr/local/bin/zellij

curl -LsSf https://astral.sh/uv/install.sh | sh

# INFO: should be the last one which modifies /home/xilinx/.bashrc
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --arch aarch64-unknown-linux-musl
grep -q 'eval "\$(zoxide init bash)"' .bashrc || echo 'eval "$(zoxide init bash)"' >>.bashrc

chown -R xilinx:xilinx /home/xilinx/.fzf
chown -R xilinx:xilinx /home/xilinx/.local
chown xilinx:xilinx /home/xilinx/.bashrc

# git config --global --unset http.proxy
# git config --global --unset https.proxy
