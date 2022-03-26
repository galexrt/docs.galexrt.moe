---
title: "Troubleshooting"
---

## General connectivity test

Kuberang is a simple but efficient way to quickly check cluster network connectivity.
To quote from the project's README:

> Quote from [GitHub apprenda/kuberang README.md](https://github.com/apprenda/kuberang):
>
* Has kubectl installed correctly with access controls
* Has active kubernetes namespace (if specified)
* Has available workers
* Has working pod & service networks
* Has working pod <-> pod DNS
* Has working master(s)
* Has the ability to access pods and services from the node you run it on.

You can run it:

```console
kuberang
```
This will start the test Deployments and Services.

## DNS Server

* https://github.com/DNS-OARC/flamethrower
