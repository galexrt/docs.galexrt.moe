---
title: Rook
---

_The source for the diagrams, can be found as `.graphml` at the same path as the images._

## Rook Ceph Components

Where the "basic" components are the rook-ceph-agent and `rook-discover` DaemonSet.

![rook-operator-cluster-architecture-overview.png](architecture/rook-operator-cluster-architecture-overview.png)

!!! note
    * Rook Ceph Discovery DaemonSet is **only started after at least one CephCluster has been created!**
    * The Rook Ceph Agent was used in earlier Rook Ceph versions for the "Flex driver" before the swaitch to use, e.g., Ceph's CSI driver.
