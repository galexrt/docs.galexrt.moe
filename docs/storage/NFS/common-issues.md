---
title: "Common Issues"
date: 2020-08-28
---

## PHP Applications hanging / timing out (e.g., Nextcloud)

In case of Nextcloud on NFS, the application was stuck / hanging at a `flock` syscall.

To "workaround" the issue, if applicable for the application (should be for most PHP applications), the NFS must be mounted with the `nolock` mount option added.
