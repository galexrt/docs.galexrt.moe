---
title: "CRI-O"
date: 2020-08-28
---

## Default CNI configs cause Cluster Network Issues

On most OSes where CRI-O is availabe as a packge, CRI-O comes with some default CNI configs located at `/etc/cni/net.d/`.
If you, e.g., will be running Kubernetes with a CNI (e.g., Calico, Cilium, Flannel), you must remove those files and restart the CRI-O service.

On a new Fedora 32 installation, the following CNI config files needed to be removed and then CRI-O service restarted:

* `/etc/cni/net.d/100-crio-bridge.conf`
* `/etc/cni/net.d/200-loopback.conf`

!!! tip
    The CRI-O service must only be restarted if the CRI-O has already been started with those CNI config files in the directory.
