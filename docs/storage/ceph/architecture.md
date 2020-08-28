---
title: "Architecture"
date: 2019-02-01
---

_The source for the diagrams, can be found as `.graphml` at the same path as the images._

## Basic Cluster with HDDs and SSDs

![ceph-architecture-cluster-basic-hdds-ssds.png](ceph-architecture-cluster-basic-hdds-ssds.png)

## Cluster with RGW for S3-compatible Object Storage

No direct OSD access network is required by the consumers of the object storage.
(^ the big advantage over CephFS)

![ceph-architecture-cluster-rgw.png](ceph-architecture-cluster-rgw.png)

## Cluster with MDS CephFS

A filesystem consumer must have direct (/ "full") network to the OSDs.

![ceph-architecture-cluster-mds.png](ceph-architecture-cluster-mds.png)

## Cluster with NVMe OSDs (+ Multi Datacenter Scenario)

![ceph-architecture-cluster-nvme-osds.png](ceph-architecture-cluster-nvme-osds.png)
