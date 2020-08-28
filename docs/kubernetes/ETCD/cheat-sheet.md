---
title: "Cheat Sheet"
date: 2019-06-22
---

## Check ETCD performance "status" quickly

```bash
ETCDCTL_API=3 etcdctl \
    [YOUR_FLAGS] \
    check perf
```

### Example

#### Kubernetes (`kubeadm`)

```bash
ETCDCTL_API=3 etcdctl \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
    check perf
```

## Get Metrics from ETCD using `curl`

!!! note
    The `/etc/etcd/etcd.conf` was actively used in OpenShift 3.x installations and some older Kubernetes deployment "methods".

```bash
# Should you still have a `etcd.conf` source it
source /etc/etcd/etcd.conf
# Otherwise replace each `$ETCD_PEER_*` with the according path
curl --cacert=$ETCD_PEER_CA_FILE --cert=$ETCD_PEER_CERT_FILE --key=$ETCD_PEER_KEY_FILE -L https://127.0.0.1:2379/metrics -XGET -v
```

## Show ETCD Cluster Members

```bash
ETCDCTL_API=3 etcdctl \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
    member list
```
