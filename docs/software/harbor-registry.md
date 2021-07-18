---
title: "Harbor Registry"
---

## Garbage Collection (GC) not working with non-AWS S3 storage?

(Non AWS S3 stores, e.g., Ceph RGW, Minio, Linode Object store and other similar stores)

See [Docker Registry - Garbage Collection doesn't work with non AWS S3 stores](docker-registry.md#garbage-collection-doesnt-work-with-non-aws-s3-stores).

## Notes

* **[Security]**: Images are **not scanned on push** by default. This option must be enabled per project / group as of today, 28.08.2020.
* **[Kubernetes]**: The Job Service `Deployment`'s `PersistentVolumeClaim` must be of type `ReadWriteMany`. Otherwise having more than `replicas: 1` will not work!
