---
title: "Preparations for 'Boot XYZ FIle'"
---

!!! danger
    Only run the following commands if you know what they are doing!

    If you already have GRUB installed and working, you probably just need to edit your `grub.cfg` file (for most OSes in the `/boot` directory).

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

        ```console
        grub2-install --no-floppy /dev/sda2
        ```

    * For GRUB:

      ```console
      grub-install --no-floppy /dev/sda2
      ```

5. Create GRUB boot config file
    * For GRUB2 the path is `/boot/grub2/grub.cfg`.
    * For GRUB the path is `/boot/grub/grub.cfg`.

Optional steps:

1. Copy your Kickstart and / or config file to the `/boot` directory
    * This assumes the "system" you are using is able to open the `/boot` mounted partition and read the file from there, e.g., Kickstart can do it like that `inst.ks="hd:UUID=__BOOT_PART_UUID__:/ks.cfg"` (where the `__BOOT_PART_UUID__` is the partition UUID).
2. Reboot and enjoy!
