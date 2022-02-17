---
title: "Common Issues"
---

## Benchmarking Ceph Storage

You want to benchmark the storage of your Ceph cluster(s)? This is a short list of tools to benchmark storage.

**Recommended tools**:

* General Benchmarking Testing of Storage (e.g., plain disks, and other storage software)
    * [`fio`](https://fio.readthedocs.io/en/latest/fio_doc.html)
        * References
            * https://github.com/axboe/fio/tree/master/examples
            * https://docs.oracle.com/en-us/iaas/Content/Block/References/samplefiocommandslinux.htm
* Ceph specific Benchmarking:
    * [`rbd bench` command](https://docs.ceph.com/en/latest/man/8/rbd/)
        * References:
            * https://tracker.ceph.com/projects/ceph/wiki/Benchmark_Ceph_Cluster_Performance
            * https://edenmal.moe/post/2017/Ceph-rbd-bench-Commands/

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

## Find Device OSD is using

### Issue

You need to find out which disk/device is used by an OSD daemon.

**Scenarios**: `smartctl` is showing that the disk should be replaced, disk has already failed, etc.

### Solution

Use the various `ls*` subcommands of `ceph device`.

```console
$ ceph device --help
device check-health                                                         Check life expectancy of devices
device get-health-metrics <devid> [<sample>]                                Show stored device metrics for the device
device info <devid>                                                         Show information about a device
device light on|off <devid> [ident|fault] [--force]                         Enable or disable the device light. Default type is `ident`
'Usage: device
                                                                             light (on|off) <devid> [ident|fault] [--force]'
device ls                                                                   Show devices
device ls-by-daemon <who>                                                   Show devices associated with a daemon
device ls-by-host <host>                                                    Show devices on a host
device ls-lights                                                            List currently active device indicator lights
device monitoring off                                                       Disable device health monitoring
device monitoring on                                                        Enable device health monitoring
device predict-life-expectancy <devid>                                      Predict life expectancy with local predictor
device query-daemon-health-metrics <who>                                    Get device health metrics for a given daemon
device rm-life-expectancy <devid>                                           Clear predicted device life expectancy
device scrape-daemon-health-metrics <who>                                   Scrape and store device health metrics for a given daemon
device scrape-health-metrics [<devid>]                                      Scrape and store device health metrics
device set-life-expectancy <devid> <from> [<to>]                            Set predicted device life expectancy
```

The `ceph device` subcommands allow you to do even more things, e.g., turn on the disk light in server chassis.
Enabling the light for the disk can help the datacenter workers to easily locate the disk and not replacing the wrong disk.

#### Locate Disk of OSD by OSD daemon ID (e.g., OSD 13):

```console
$ ceph device ls-by-daemon osd.13
DEVICE                                     HOST:DEV                                           EXPECTED FAILURE
SAMSUNG_MZVL2512HCJQ-00B00_S1234567890123  HOSTNAME:nvme1n1
```

#### Show all disks by host (hostname):

```console
$ ceph device ls-by-host HOSTNAME
DEVICE                                     HOST:DEV                                           EXPECTED FAILURE
DEVICE                                     DEV      DAEMONS  EXPECTED FAILURE
SAMSUNG_MZVL2512HCJQ-00B00_S1234567890123  nvme1n1  osd.5
SAMSUNG_MZVL2512HCJQ-00B00_S1234567890123  nvme0n1  osd.2
SAMSUNG_MZVL2512HCJQ-00B00_S1234567890123  nvme2n1  osd.8
SAMSUNG_MZVL2512HCJQ-00B00_S1234567890123  nvme3n1  osd.13
```

***

Should this page not have yielded you a solution, checkout the [Rook Ceph Common Issues](../rook/common-issues.md) doc as well.
