---
title: ".iso File"
date: 2020-08-28
---

!!! info
    You must have a working GRUB installation already, if not checkout the [Preparations for Boot ](../preparations-for-boot-xyz-file.md).

Why would you need this? When you don't have a KVM or just don't want to use ILO, iDRAC, iPMI or other management tools to mount an ISO.

This snippet is from a try to install Fedora CoreOS from an ISO file named `install.io` from the `/boot` partition.

Example `grub.cfg` contents (`coreos.inst.install_dev=sda` would use the `sda` device for installation in case of *CoreOS):

```ini
set default=0
set timeout=5
# Fedora Kickstart Install
 menuentry "Fedora Kickstart Install" {
    search --no-floppy --fs-uuid __BOOT_PART_UUID__ --set root
    # Booting an ISO
    loopback loop /install.iso
    linux (loop)/images/vmlinuz coreos.inst=yes coreos.inst.install_dev=sda coreos.inst.ignition_url=http://example.com/example.ign
    initrd (loop)/images/initramfs.img
}
```

It worked fine though the original case was to load the Ignition file from the boot disk which didn't work, a Webserver / Matchbox server was required to load the Ignition file from.
