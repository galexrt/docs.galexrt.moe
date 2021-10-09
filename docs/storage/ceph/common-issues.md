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

## `MDSs report oversized cache`

### Issue

Ceph health status reports, e.g., `1 MDSs report oversized cache`.

```
[root@rook-ceph-tools-86d54cbd8d-6ktjh /]# ceph -s
  cluster:
    id:     67e1ce27-0405-441e-ad73-724c93b7aac4
    health: HEALTH_WARN
            1 MDSs report oversized cache
[...]
```

### Solution

You can try to increase the `mds cache memory limit` setting[^1].

!!! tip
    For Rook Ceph users, you set/increase the memory requests on the CephFilesystem object for the MDS daemons[^2].

[^1]: Report / Source for information regarding this issue has been taken from http://lists.ceph.com/pipermail/ceph-users-ceph.com/2019-December/037633.html
[^2]: [Rook Ceph Docs v1.7 - Ceph Filesystem CRD - MDS Resources Configuration Settings](https://rook.io/docs/rook/v1.7/ceph-filesystem-crd.html#mds-resources-configuration-settings)
