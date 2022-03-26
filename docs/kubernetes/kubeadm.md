---
title: "kubeadm"
---

## kubeadm Cluster Installation

Checkout the official Kubernetes documentation links:

* Installation of kubeadm: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
* Kubernetes Cluster Creation using kubeadm:
    * Single Control Plane Cluster: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
    * Highly available Cluster:
        * Options for highly available clusters: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/
        * Basic highly available cluster: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/

## Prometheus (kube-prometheus) ETCD Metrics Access

You need to create a secret that contains the ETCD healthcheck client cert and key.

```console
kubectl \
    create \
    -n monitoring \
    secret generic \
    etcd-client-cert \
    --from-file=/etc/kubernetes/pki/etcd/ca.crt \
    --from-file=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
    --from-file=/etc/kubernetes/pki/etcd/healthcheck-client.key
```

For more information checkout this comment: https://github.com/prometheus-community/helm-charts/issues/204#issuecomment-765155883
