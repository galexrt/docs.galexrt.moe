---
title: "node_exporter by Prometheus Project"
---

* Website / Source Code: https://github.com/prometheus/node_exporter
* Port: `9100/TCP`
* Path: `/metrics`
* Auth: None. (Recommendation: Add (Kubernetes) OAuth Proxy in front)
* What can the Metrics tell us:
    * OS metrics (e.g., `cpu`, `loadavg`, `meminfo` and many more).
        * The exporter can export a ton of metrics for Linux based systems.

Can export metrics for the following OSes: Darwin, Dragonfly, FreeBSD, Linux, NetBSD, OpenBSD, Solaris.

Not all metrics are available for each OS (e.g., only Linux has `mdadm` metrics).
For a list of metrics per OS, see https://github.com/prometheus/node_exporter#enabled-by-default and https://github.com/prometheus/node_exporter#disabled-by-default.

Special point about the node_exporter is that it can export metrics from textiles that are in a certain format, see https://github.com/prometheus/node_exporter#textfile-collector.
SMART metrics are normally exported like this (e.g., https://github.com/galexrt/docker-node_exporter-smartmon for a container image that runs the smartctl script every X time).
