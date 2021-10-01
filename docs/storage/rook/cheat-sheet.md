---
title: Cheat Sheet
---

## Get PersistentVolume and PersistentVolumeClaim from `csi-vol-...` Name in Kubernetes

Replace `csi-vol-............` with the volume name:

```console
$ kubectl get pv -o jsonpath='{range .items[?(@.spec.csi.volumeAttributes.imageName=="csi-vol-............")]}{.metadata.name}{"\t"}{.spec.claimRef.namespace}{"/"}{.spec.claimRef.name}{"\n"}{end}'
```
