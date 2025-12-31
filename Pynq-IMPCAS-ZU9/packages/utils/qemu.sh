#!/bin/bash

set -e
set -x

. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

export HOME=/root

# INFO: don't add sudo
apt install -y \
  ripgrep smbclient avahi-utils btop iotop sysstat strace ltrace \
  u-boot-tools tio net-tools minicom libtool \
  cmake autoconf automake gdb-multiarch gdbserver valgrind ninja-build \
  git-lfs screen xterm gawk xz-utils util-linux

apt install -y bc bison flex libssl-dev libelf-dev libncurses-dev libfdt-dev


cd /home/xilinx

git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
echo -e "y\\ny\\ny\\n" .fzf/install
chown -R xilinx:xilinx .fzf

wget -qO- https://github.com/zellij-org/zellij/releases/latest/download/zellij-aarch64-unknown-linux-musl.tar.gz | \
  sudo tar -xzf - -C /usr/local/bin/ zellij && sudo chmod +x /usr/local/bin/zellij

curl -LsSf https://astral.sh/uv/install.sh | sh

# INFO: should be the last one which modifies /home/xilinx/.bashrc
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --arch aarch64-unknown-linux-musl
grep -q 'eval "\$(zoxide init bash)"' .bashrc || echo 'eval "$(zoxide init bash)"' >> .bashrc
