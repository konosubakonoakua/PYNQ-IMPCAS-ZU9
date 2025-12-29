## Build PYNQ SD Image for Pynq-IMPCAS-ZU9

### Prerequisites

```
* Open https://petalinux.xilinx.com/ in a web browser. this makes sure we have a good connection to the yocto downloads.
* Set "Defaults:username timestamp_timeout=120" in the sudoers file for a 120-minute password-free session.
```

**Required tools:**

* Ubuntu 22.04 LTS 64-bit host PC
* Passwordless SUDO privilege for the building user
* Roughly 35GB of free space (build process only, not accounting for Xilinx tools)
* At least 8GB of RAM (more is better)
* AMD PetaLinux 2024.1 and Vivado 2024.1

You can find the instructions to setup the environment here https://pynq.readthedocs.io/en/latest/pynq_sd_card.html#prepare-the-building-environment

Retrieve the `Pynq-IMPCAS-ZU9` board git into a NEW directory.

```shell
git clone https://github.com/konosubakonoakua/PYNQ-IMPCAS-ZU9.git <LOCAL_PYNQ-IMPCAS-ZU9_REPO>
cd <LOCAL_PYNQ-IMPCAS-ZU9_REPO> && git submodule init && git submodule update
```

### Build SD Image

PYNQ is a submodule and it points to the corresponding branch.

Configure and install build tools, this will take some effort and will be an iterative process. Install on your own any missing tools.

Inside the `<LOCAL_PYNQ-IMPCAS-ZU9_REPO>/` execute

```shell
source /tools/Xilinx/Vivado/2024.1/settings64.sh
source /tools/Petalinux/2024.1/settings.sh
cd pynq/sdbuild
make checkenv
```

In the root directory (`<LOCAL_PYNQ-IMPCAS-ZU9_REPO>/`) run `make`.

```shell
taskset -c 0,1,2,3 make 2>&1 | tee build.log
```

Once the build has completed, if successful a SD card image will be available under the directory `<LOCAL_PYNQ-IMPCAS-ZU9_REPO>/sdbuild/output/Pynq-IMPCAS-ZU9-3.1.2.img`.

Use Etcher or Win32DiskImager or Rufus to write this image to an SD card.

---------------------------------------
