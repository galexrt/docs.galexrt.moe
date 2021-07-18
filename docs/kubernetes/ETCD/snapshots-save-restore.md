---
title: "Snapshots: Save & Restore"
---

!!! warning
    This page is only for ETCD version `3.x` and higher!

> For the original commands and more information on ETCD, see https://coreos.com/etcd/docs/latest/op-guide/recovery.html.

## Take a snapshot

```bash
ETCDCTL_API=3 etcdctl \
    --endpoints $ETCD_ENDPOINT \
    snapshot save snapshot.db
```

(where `snapshot.db` is the name of the snapshot file to be created)

## Restore a snapshot

!!! danger
    Before restoring a snapshot, all ETCDs in the cluster must be stopped!

You must rename/remove the current data dir (probably `/var/lib/etcd`).

Be sure to provide all flags that are specified in, e.g., systemd unit file, Kubespray: `/etc/etcd.env` and others otherwise you may create issues for the ETCD cluster!

The command is looking about like that depending on what flags are used for your ETCD node:

```bash
# Run the command as `root` user after that use `chown` to correct ownership of files
ETCDCTL_API=3 etcdctl \
    snapshot restore snapshot.db \
    --name m1 \
    --initial-cluster m1=http://host1:2380,m2=http://host2:2380,m3=http://host3:2380 \
    --initial-cluster-token etcd-cluster-1 \
    --initial-advertise-peer-urls http://host1:2380
    --data-dir=/var/lib/etcd

# chown etcd:etcd -R /var/lib/etcd
```

This has to be done on all ETCD servers one by one with each having their own name given by flag as they were when the snapshot was taken.
