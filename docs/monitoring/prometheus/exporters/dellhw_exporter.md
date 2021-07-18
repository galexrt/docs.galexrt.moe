---
title: "dellhw_exporter by galexrt"
---

* Website / Source Code: https://github.com/galexrt/dellhw_exporter
* Port: `9137/TCP`
* Path: `/metrics`
* Auth: None. (Recommendation: Add (Kubernetes) OAuth Proxy in front)
* What can the Metrics tell us:
    * Dell HW status through the use of Dell's OMSA `omreport` tool.

***

The dellhw_exporter uses Dell Open Manage Server Administrator `omreport` to get metrics from Dell hardware.

For more info, visit the GitHub repository: https://github.com/galexrt/dellhw_exporter.

!!! info
    The exporter is written by the project contributors, initially created by [Alexander Trost](https://github.com/galexrt).
