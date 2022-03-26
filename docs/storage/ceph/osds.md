---
title: "OSDs"
---

## OSD Maintenance

### Gracefully remove OSD

!!! tip
    If you are using Rook Ceph Operator to run a Ceph Cluster in Kubernetes, please follow the official documentation here: [Rook Docs - Ceph OSD Management](https://rook.io/docs/rook/v1.4/ceph-osd-mgmt.html#remove-an-osd).

First thing is to set the crush weight to zero, either instantly to `0.0` or a bit gracefully*.
(*gracefully should always be used when the cluster is in use, though any OSD weight change will cause data redistribution)

```console
ceph osd crush reweight osd.<ID> 0.0
```

or graceful:

```console
for i in {9 1}; do
    ceph osd crush reweight osd.<ID> 0.$i
    # Wait five minutes each step or longer depending on your Ceph cluster recovery speed
    sleep 300
done
```

After the reweight, set the OSD out and remove it (+ its credentials):

```console
ceph osd out <ID>
```

```console
ceph osd crush remove osd.<ID>
ceph auth del osd.<ID>
ceph osd rm <ID>
```
