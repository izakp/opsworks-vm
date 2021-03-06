#!/bin/bash -eux

if [ -f /home/vagrant/.vbox_version ]; then
    echo "==> Installing VirtualBox guest additions"
    # Assuming the following packages are installed
    # apt-get install -y linux-headers-$(uname -r) build-essential perl
    # apt-get install -y dkms

    VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
    mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
    sh /mnt/VBoxLinuxAdditions.run
    umount /mnt
    rm /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso
    rm /home/vagrant/.vbox_version

    if [[ $VBOX_VERSION = "4.3.10" ]]; then
        ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
    fi
fi

if [ -f /home/vagrant/vmware_tools.iso ]; then
    echo "==> Installing VMware Tools"
    # Assuming the following packages are installed
    # apt-get install -y linux-headers-$(uname -r) build-essential perl

    cd /tmp
    mkdir -p /mnt/cdrom
    mount -o loop /home/vagrant/vmware_tools.iso /mnt/cdrom
    tar zxf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/

    /tmp/vmware-tools-distrib/vmware-install.pl -d

    rm /home/vagrant/vmware_tools.iso
    umount /mnt/cdrom
    rmdir /mnt/cdrom
    rm -rf /tmp/VMwareTools-*
fi