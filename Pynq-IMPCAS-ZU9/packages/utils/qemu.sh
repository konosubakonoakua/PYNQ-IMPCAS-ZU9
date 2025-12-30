#!/bin/bash

echo "Install utils via APT..."
sudo apt install -y \
  ripgrep smbclient avahi-utils btop iotop sysstat strace ltrace \
  u-boot-tools tio net-tools minicom libtool \
  cmake autoconf automake gdb-multiarch gdbserver valgrind ninja-build \
  git-lfs screen xterm gawk xz-utils util-linux
sudo apt install -y bc bison flex libssl-dev libelf-dev libncurses-dev libfdt-dev

echo "Install fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo -e "y\\ny\\ny\\n" ~/.fzf/install

echo "Install zellij..."
wget -qO- https://github.com/zellij-org/zellij/releases/latest/download/zellij-aarch64-unknown-linux-musl.tar.gz | sudo tar -xzf - -C /usr/local/bin/ zellij && sudo chmod +x /usr/local/bin/zellij

echo "Install uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Install zoxide (this should be the last one)..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
grep -q 'eval "\$(zoxide init bash)"' ~/.bashrc || echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
