---
title: "GRUB Tricks"
date: 2020-01-31
---

## Get GRUB on disk for booting "things"

The disk to be used should be:

* Boot Target in BIOS / UEFI
* First in the BIOS / UEFI boot order

The disk used in this example is `/dev/sda`.

1. Prepare Disk partition layout
   * Create two partitions on the disk (use, e.g., `fdisk`, `parted`, etc)
     * 1MB  (flags: `boot`)
     * 10G or more as you want / need (flags: `boot`), `ext4` formatted
   * Run `blkid /dev/sda2 -s UUID -o value` to get the UUID of the "first" disk's second partition.
     * Save the UUID of the "first" disk down. The UUID of the "first" disk will be used in form of the `__BOOT_PART_UUID__` later on.
2. Mount "boot" Partition
   * Mount the second created partition (`/dev/sda2`): `mount /dev/sda2 /boot`.
3. Download Fedora `vmlinuz`, `initramfs` and `install.img` to `/boot` directory.
   * Prefix the downloaded files with `fedora-` (or whatever you want as long as you change it in the upcoming steps as well)
4. Grub Installation
    * For GRUB2:

        ```bash
        grub2-install --no-floppy /dev/sda2
        ```

    * For GRUB:

      ```bash
      grub-install --no-floppy /dev/sda2
      ```

5. Create GRUB boot config file
   * For GRUB2 the path is `/boot/grub2/grub.cfg`.
   * For GRUB the path is `/boot/grub/grub.cfg`.

Optional steps:

1. Copy your Kickstart and / or config file to the `/boot` directory
   * This assumes the "system" you are using is able to open the `/boot` mounted partition and read the file from there, e.g., Kickstart can do it like that `inst.ks="hd:UUID=__BOOT_PART_UUID__:/ks.cfg"` (where the `__BOOT_PART_UUID__` is the partition UUID).
2. Reboot and enjoy!

## Boot XYZ file through GRUB

### Boot `.img` file

Example `grub.cfg` contents:

```json
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

### Boot ISO

Why would you need this? When you don't have a KVM or just don't like to use ILO / iDRAC or other similar management tools to mount an ISO.

This snippet is from a try to install Fedora CoreOS from an ISO file named `install.io` from the `/boot` partition.

Example `grub.cfg` contents (`coreos.inst.install_dev=sda` would use the `sda` device for installation in case of *CoreOS):

```json
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
