---
title: "System Requirements"
date: 2019-08-20
---

!!! tip "Recommendations for Requirements"
    These are **recommendations** for requirements of Kubernetes Masters and Nodes.

## General

Network:

* Bandwidth: at the very least 1G, recommended for smaller, lower traffic environents is 10G, 25G or more.
  * Note: To reduce costs you get away with just having a single interface, instead of, e.g., 2 bonded interfaces, though having 2 will allow for more performance and also the server still being reachable in case of failure.

## Master

### Storage

!!! warning "SSDs or even NVMe based storage is more expensive but your ETCD will love and need it!"
    **DO NOT USE** HDDs nor any kind of networked storage for ETCD!

    Even a fast Ceph RBD (e.g., when running in VMs) can look good in the beginning but might "kill" the ETCD performance in the end!

    **Too many users of Kubernetes or OpenShift do that and end up with slow performing clusters in many different ways, simply because the ETCD is slow (even though the kube-apiservers are caching a lot)**

Use SSDs or any other storage with **low latencies** (LOW)! ETCD is pretty much latency bound, it needs its "few" IOPS as well but latency is the killer (sequential writing, e.g., WAL and DB).
