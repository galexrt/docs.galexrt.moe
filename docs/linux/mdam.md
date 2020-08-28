---
title: "mdadm"
date: 2020-01-31
---

Checkout the [mdadm man page](https://linux.die.net/man/8/mdadm).

!!! note
    Don't forget to keep your [`mdadm.conf`](https://linux.die.net/man/5/mdadm.conf) uptodate when creating, modifiying, deleting mdadm arrays.

## Generate `mdadm.conf`

```bash
mdadm --detail --scan >> /etc/mdadm.conf
```

## Grow RAID 5 to RAID 6

!!! danger
    **DON'T FORGET TO SPECIFY THE `--backup-file=FILE` for `mdadm --grow` operations!**
    Otherwise if the host is (forced) shutdowned (e.g., power failure), data can / will be lost.

(This "backup file" should be on different disk / storage, not on the mdadm array you are growing!)

## Speed up RAID rebuild

!!! note 
    This may or may not improve your mdadm RAID rebuild performance.

This assumes your disks are `sda`, `sdb` and `sdc`, and the RAID array is `md0` (`/dev/md0`).

```bash
for disk in sd{a..c}; do
    blockdev --setra 16384 "/dev/${disk}"
    echo 1024 > "/sys/block/${disk}/queue/read_ahead_kb"
    echo 256 > "/sys/block/${disk}/queue/nr_requests"
    # Disable NCQ on all disks.
    echo 1 > "/sys/block/${disk}/device/queue_depth"
done
# Set read-ahead to 64 MiB for /dev/md0
blockdev --setra 65536 /dev/md0
# Set stripe_cache_size to 16 MiB for /dev/md0
echo 16384 > /sys/block/md0/md/stripe_cache_size
```
