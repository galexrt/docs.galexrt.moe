---
title: "Cheat Sheet"
date: 2018-05-24
---

## Allow unsupported Transceivers to be used

```shell
enable
configure terminal
no errdisable detect cause gbic-invalid
service unsupported-transceiver
exit
```

## Quick setup "cheap" network

More to come here to get a Cisco switch running with "cheap" network equipment.

```shell
enable
configure terminal
no errdisable detect cause gbic-invalid
service unsupported-transceiver
exit
```
