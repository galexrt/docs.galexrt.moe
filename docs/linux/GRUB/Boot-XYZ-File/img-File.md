---
title: ".img File"
date: 2020-08-28
---

!!! info
    You must have a working GRUB installation already, if not checkout the [Preparations for Boot ](../preparations-for-boot-xyz-file.md).

Example `grub.cfg` (for Fedora CoreOS installation):

```ini
set default=0
set timeout=5
# Fedora Kickstart Install
menuentry "Fedora Kickstart Install" {
    search --no-floppy --fs-uuid __BOOT_PART_UUID__ --set root
    # Add aditional kernel command line arguments at the end of the next line
    linux /fedora-vmlinuz selinux=0 inst.resolution=800x600 inst.ks="hd:UUID=__BOOT_PART_UUID__:/ks.cfg" inst.stage2="hd:UUID=__BOOT_PART_UUID__:/fedora-install.img"
    initrd /fedora-initrd.img
}
```
