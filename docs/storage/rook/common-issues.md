---
title: "Common Issues"
date: 2019-08-28
---

Be sure to checkout the [Rook Ceph Common Issues page](https://rook.io/docs/rook/v1.6/ceph-common-issues.html) and **that all prerequisites for the storage backend of your choice** are met!

* [General Rook prerequisites]()
* [Ceph prerequisites](https://rook.io/docs/rook/v1.6/ceph-prerequisites.html)

***

# Ceph

## Where did the `rook-discover-*` Pods go after a recent Rook Ceph update?

A recent change in Rook Ceph has disabled the `rook-discover` DaemonSet by default.
This behavior is controlled by the `ROOK_ENABLE_DISCOVERY_DAEMON` located in the `operator.yaml` or for Helm users `enableDiscoveryDaemon: (false|true` in your values file. It is a boolean, so `false` or `true`.

### When do you want to have `rook-discover-*` Pods / `ROOK_ENABLE_DISCOVERY_DAEMON: true`?

* You are on **(plain) bare metal** and / or simply have "some disks" installed /attached to your server(s), that you want to use for the Rook Ceph cluster.
* If your cloud environment / provider does not provide PVCs with `volumeMode: Block`. Ceph requires block devices (Ceph's `filestore` is not available, through Rook, since a bunch of versions as `bluestore` is superior in certain ways).

## No `rook-ceph-mon-*` Pods are running

1. First of all make sure your Kubernetes CNI is working fine! In what feels like 90% of the cases it is network related, e.g., some weird thing with the Kubernetes cluster CNI or other network environment issue.
    * Can you talk to Cluster Service IPs from every node?
    * Can you talk to Pod IPs from every node? Even to Pods not on the same node you are testing from?
    * Check the docs of your CNI, most have a troubleshooting section, e.g., Cilium had some issues from systemd version 245 onwards with `rp_filter`, see here: [rp_filter (default) strict mode breaks certain load balancing cases in kube-proxy-free mode · Issue #13130 · cilium/cilium](https://github.com/cilium/cilium/issues/13130)
2. Does your environment fit all the prerequisites? Check top of page for the links to some of the prerequisites and / or consult the [Rook.io docs](https://rook.io/).
3. Check the `rook-ceph-operator` Logs for any warnings, errors, etc.

### Disk(s) / Partition(s) not used for Ceph

* Does section [When do you want to have `rook-discover-*` Pods / `ROOK_ENABLE_DISCOVERY_DAEMON: true`?](#when-do-you-want-to-have-rook-discover--pods--rook_enable_discovery_daemon-true) apply to you? If so, make sure the operator has the discovery daemon enabled in its (Pod) config!
* Is the disk empty? No leftover partitions on it? Make sure it is either "empty", e.g., nulled by `shred`, `dd` or similar,
    * To make sure the disk is blank as the Rook docs and I recommend the following commands followed by a reboot of the server:
        ```
        DISK="/dev/sdXYZ"
        sgdisk --zap-all "$DISK"
        dd if=/dev/zero of="$DISK" bs=1M count=100 oflag=direct,dsync
        blkdiscard "$DISK"
        ```
        Source: [https://rook.io/docs/rook/v1.6/ceph-teardown.html#delete-the-data-on-hosts](https://rook.io/docs/rook/v1.6/ceph-teardown.html#delete-the-data-on-hosts)
* Was the disk previously used as a Ceph OSD?
    * Make sure to follow the teardown steps, but make sure to only remove the LVM stuff from that one disk and not from all, see [https://rook.io/docs/rook/v1.6/ceph-teardown.html#delete-the-data-on-hosts](https://rook.io/docs/rook/v1.6/ceph-teardown.html#delete-the-data-on-hosts).

### A Pod can't mount its PersistentVolume after an "unclean" / "undrained" Node shutdown

1. Check the events of the Pod using `kubectl describe pod POD_NAME`.
2. Check the Node's `dmesg` logs.
3. Check the kubelet logs for errors related to CSI connectivity and / or make sure the node can reach every other Kubernetes cluster node (at least the Rook Ceph cluster nodes (Ceph Mons, OSDs, MGRs, etc.)).
4. Checkout the [CSI Common Issues - Rook Docs](https://rook.io/docs/rook/v1.6/ceph-csi-troubleshooting.html).

### Ceph CSI: Provisioning, Mounting, Deletion or something doesn't work

Make sure you have checked out the [CSI Common Issues - Rook Docs](https://rook.io/docs/rook/v1.6/ceph-csi-troubleshooting.html).

If you have some weird kernel and / or kubelet configuration, make sure Ceph CSI's config options in the Rook Ceph Operator config is correctly setup (e.g., `LIB_MODULES_DIR_PATH`, `ROOK_CSI_KUBELET_DIR_PATH`, `AGENT_MOUNTS`).
