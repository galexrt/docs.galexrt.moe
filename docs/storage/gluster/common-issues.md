---
title: "Common Issues"
---

## No File Locking

!!! note
    The described case here is a define "no-go" to run on a GlusterFS, but it is worth to mention as some other applications (possibly git and others) might have issues in the long run as well.

GlusterFS doesn't seem to have file locking, meaning that, e.g., a SQLite database will corrupt if multiple hosts try to access it.
