#!/bin/bash
# ZenithOS: A Fedora-based custom atomic image using the Cinnamon desktop environment


set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 up -y && dnf5 group install cinnamon-desktop base-graphical container-management core fonts hardware-support multimedia networkmanager-submodules printing virtualization -y
dnf5 install -y \
    bootc \
    fedpkg \
    gcc \
    curl \
    flatpak \
    ostree \
    papirus-icon-theme \
    human-theme-gtk \
    fish \
    abootimg \
    gnome-disk-utility \
    meson \
    bat \
    wget \
    git \
    clang \
    make \
    cmake \
    gdb \
    glib \
    lld \
    pre-commit \
    vim \
    ffmpeg \
    nano \
    archivemount \
    binwalk \
    f3 \
    fuse-dislocker \
    gnome-themes-extra \
    gsmartcontrol \
    lzip \
    lpf-mscore-fonts \
    plank \
    slick-greeter \
    waydroid \
    guake \
    btrfs-assistant \
    torbrowser-launcher \

    lightdm

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

dnf5 -y copr enable wojnilowicz/ungoogled-chromium
dnf5 -y install ungoogled-chromium
dnf5 -y copr disable wojnilowicz/ungoogled-chromium

sed -i 's/^unix_sock_group.*/unix_sock_group = "libvirt"/' /etc/libvirt/libvirtd.conf
sed -i 's/^unix_sock_rw_perms.*/unix_sock_rw_perms = "0770"/' /etc/libvirt/libvirtd.conf

chsh -s $(which fish)

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable libvirtd
systemctl enable lightdm.service

