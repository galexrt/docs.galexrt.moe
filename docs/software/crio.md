---
title: "CRI-O"
---

## Default CNI configs causes Cluster Network Issues

!!! hint
    If you use CRI-O with Kubernetes, you should always remove these default CNI config files!

On most operating systems where CRI-O can be installed through a packge, CRI-O comes with some default CNI configs located at `/etc/cni/net.d/` (default directory).
That means if you run Kubernetes or anything else that "brings its own CNI" (e.g., Calico, Cilium, Flannel, etc.) you need to remove those files.

Currently it should be those two files that need to be removed:

* `/etc/cni/net.d/100-crio-bridge.conf`
* `/etc/cni/net.d/200-loopback.conf`

!!! tip
    If CRI-O was already running/started at the time of removing these CNI config files, you need to restart the `crio` service on the server(s).

    Using `sudo` or as the root user run the following to restart the `crio` service on servers that use systemd as the "service manager":

    ```console
    systemctl restart crio
    ```
