---
title: "Cluster Components Upgrade Order"
---

The following is a recommended Upgrade Order for the Components of a Kubernetes cluster:

* Control Plane Components
    1. `kube-apiserver`
    1. `kube-controller-manager`
        1. If used, `cloud-controller-manager`
    1. `kube-scheduler`
    2. `etcd`
* Node Components
    1. `kubelet`
    1. `kube-proxy`

Other components of a Kubernetes cluster can mostly be updated in any order, as long as the documentation of the component doesn't state otherwise:

* CNI (e.g., Calico, Cillium)
* Operators

!!! warning
    Be aware of any changes to the operator configs and CustomResourceDefinitions causing unwanted "results".

    E.g., new versions of CustomResourceDefinitions have new fields and / or change the behavior.
