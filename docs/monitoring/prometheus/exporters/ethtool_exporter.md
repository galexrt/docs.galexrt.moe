---
title: "ethtool_exporter by Showmax"
date: 2018-05-16
---

## Info

* Website / Source Code: https://github.com/Showmax/prometheus-ethtool-exporter
* Port: `9417/TCP` (can also export to prom textilfe format)
* Path: `/metrics`
* Auth: None. (Recommendation: Add (Kubernetes) OAuth Proxy in front)
* What can the Metrics tell us:
    * Interface information like SFP status / information and other interesting network interface details.

***

Exports interface metrics using the `ethtool` tool.

E.g., reports metrics such as temperature, dampening, etc., of SFP interfaces (the SFPs need to have / support [Digital Diagnostic Monitoring (DDM)](https://en.wikipedia.org/wiki/Small_form-factor_pluggable_transceiver#Digital_diagnostics_monitoring)).
