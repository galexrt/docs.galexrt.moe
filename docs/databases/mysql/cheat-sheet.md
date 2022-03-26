---
title: "Cheat Sheet"
---

## Re-Create the `debian-sys-maint` User

```console
mysqldump --complete-insert --extended-insert=0 -u root -p mysql | grep 'debian-sys-maint'
```
