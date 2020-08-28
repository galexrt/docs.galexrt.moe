---
title: "Issues"
date: 2019-03-23
---

## `HEALTH_WARN 1 large omap objects`

### Issue

```
HEALTH_WARN 1 large omap objects
# and/or
LARGE_OMAP_OBJECTS 1 large omap objects
```

### Solution

The following command should fix the issue:

```bash
radosgw-admin reshard stale-instances rm
```
