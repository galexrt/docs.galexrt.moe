---
title: "Common Issues"
---

## CephFS mount issues on Hosts

Make sure you have a (active) Linux kernel of version `4.17` or higher.

!!! tip
    In general it is recommended to have a very up-to-date version of the Linux kernel, as many improvements have been made to the Ceph kernel drivers in newer kernel versions (`5.x` or higher).

## `HEALTH_WARN 1 large omap objects`

### Issue

```
HEALTH_WARN 1 large omap objects
# and/or
LARGE_OMAP_OBJECTS 1 large omap objects
```

### Solution

The following command should fix the issue:

```bash
radosgw-admin reshard stale-instances rm
```
