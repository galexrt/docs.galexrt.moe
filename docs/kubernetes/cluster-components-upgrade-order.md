---
title: "Cluster Components Upgrade Order"
---

The following is a recommended Upgrade Order for the Components of a Kubernetes cluster:

* Master Components
    1. `kube-apiserver`
    1. `kube-controller-manager`
        1. If used, `cloud-controller-manager`
    1. `kube-scheduler`
* Node Components
    1. `kubelet`
    1. `kube-proxy`

Other components of a Kubernetes cluster can mostly be updated in any order, as long as the documentation of the component doesn't state otherwise:

* CNI (e.g., Calico, Cillium)
* `etcd`
* Operators
  * Be aware of potential changes in the operator causing unwanted "results".
