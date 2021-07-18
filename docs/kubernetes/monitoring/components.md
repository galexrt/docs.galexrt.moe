---
title: "Components"
---

Infrastructure / Cluster components should be monitored separately from your applications.
This allows you to "kill" the application Prometheus in case you have screwed up in some way (e.g., messed up application metrics causing to have a billion labeled metrics).

## Master Components

### etcd

* Summary: "Why do my kubectl commands take so long?"
* Port: `2379/TCP`
* Path: `/metrics`
* Auth: Client Certificate
    * Notes:
        * Thanks to etcd having a role concept, can be a "separate" user with just metrics access.
        * Additionally one might want to run a Kubernetes authenticated OAuth proxy in front of th etcd so that the (one or more) Prometheus can be granted access to it by RoleBinding a Role to the ServiceAccount.
        * E.g., you can create a Secret with the ETCD certificate and key using the `kubectl create secret generic --from-file=.../ca.crt --from-file=.../monitoring.crt  --from-file=.../monitoring.key`
            * Be sure to mount that Secret inside your Prometheus instance and adjust the path(s) according to the `mountPath`.
        * Prometheus Config Scrape Job Reference, see [References Prometheus Kubernetes ETCD Scrape Job Config](#prometheus-etcd-scrape-job).
* What can the Metrics tell us:
    * ETCD disk write latencies (they should be low, very low).
    * ETCD Quorum status as well (+ some other metrics, e.g., how many requests / streams).
    * Golang Process information (e.g., CPU, memory, GC status).

### kube-apiserver

* Summary: "Why do my kubectl commands take so long?"
* Port: `6443/TCP` (depends on your installation)
* Path: `/metrics`
* Auth: ServiceAccount token.
    * Note(s):
        * RBAC ClusterRole needed, see [References Prometheus ClusterRole](#prometheus-clusterrole) and [References Prometheus Per-Namespace Role](#prometheus-per-namespace-role).
* What can the Metrics tell us:
    * API Request latencies (kubectl, operators, scheduler, controller, etc).
        * Best used with `histogram_quantile()` Prometheus func over some time.
    * Admission step and webhook controller durations and latencies.
    * ETCD request metrics.
    * API server cache metrics.
    * Kubernetes API Rest Client latency, requests and duration metrics (own requests made).
    * Golang Process information (e.g., CPU, memory, GC status).

### kube-scheduler

* Summary: "How long do my Pods take to be scheudled?" (Hints at "you need to change your scheduler config")
* Port: `443/TCP` (depends on your installation)
* Path: `/metrics`
* Auth: ServiceAccount token.
    * Note(s):
        * RBAC ClusterRole needed, see [References Prometheus ClusterRole](#prometheus-clusterrole) and [References Prometheus Per-Namespace Role](#prometheus-per-namespace-role).
        * The kube-scheduler needs to either listen on `::` (`0.0.0.0`) or have a proxy which is available to Prometheus for scraping running.
* What can the Metrics tell us:
    * "How long do my Pods take to be scheudled?" (`scheduler_binding_*`)
    * Pod Preemption Algorithm latencies and more.
    * Volume scheduling duration.
    * Kubernetes API Rest Client latency, requests and duration metrics (own requests made to the API).
    * Golang Process information (e.g., CPU, memory, GC status).

### kube-controller-manager

!!! info
    If the cloud controller is used, it should also be monitored / scraped for metrics.

* Summary: "How long do my Pods take to be scheudled?" (Hints at "you need to change your scheduler config")
* Port: `443/TCP` (depends on your installation)
* Path: `/metrics`
* Auth: ServiceAccount token.
    * Note(s):
        * RBAC ClusterRole needed, see [References Prometheus ClusterRole](#prometheus-clusterrole) and [References Prometheus Per-Namespace Role](#prometheus-per-namespace-role).
        * The kube-controller-manager needs to either listen on `::` (`0.0.0.0`) or have a proxy which is available to Prometheus for scraping running.
* What can the Metrics tell us:
    * Work queue item count and duration, and lease holder status.
    * Kubernetes API Rest Client latency, requests and duration metrics (own requests made to the API).
    * Golang Process information (e.g., CPU, memory, GC status).

### kubelet (+ cadvisor)

See [Node Components - kubelet](#kubelet-cadvisor-1).

### kube-proxy

See [Node Components - kube-proxy](#kube-proxy-1).

### SDN (e.g., Calico, Cilium)

See [Node Components - kube-proxy](#sdn-e-g-calico-cilium-1).

## Node Components

### kubelet (+ "cadvisor")

* Summary: "How long do my Pods take to be scheudled?" (Hints at "you need to change your scheduler config")
* Port: `443/TCP` (depends on your installation)
* Path: `/metrics`
* Auth: ServiceAccount token.
    * Note(s):
        * RBAC ClusterRole needed, see [References Prometheus ClusterRole](#prometheus-clusterrole) and [References Prometheus Per-Namespace Role](#prometheus-per-namespace-role).
        * kubelet needs to have the following flags active: `--authorization-mode=Webhook` and `--authentication-token-webhook=true`.
* What can the Metrics tell us:
    * `kubelet_node_config_error` good to know if the latest config works.
    * Kubelet PLEG ("container runtime status") metrics.
    * "Pod Start times" (use `histogram_quantile()`).
    * CGroup metrics of containers (cpu, memory, network) with Namespace and Pod labels.
    * Kubernetes API Rest Client latency, requests and duration metrics (own requests made to the API).
    * Golang Process information (e.g., CPU, memory, GC status).

### kube-proxy

* Summary: "How long do my Pods take to be scheudled?" (Hints at "you need to change your scheduler config")
* Port: `10250/TCP` (depends on your installation)
* Path: `/metrics`
* Auth: ServiceAccount token.
    * Note(s):
        * RBAC ClusterRole needed, see [References Prometheus ClusterRole](#prometheus-clusterrole) and [References Prometheus Per-Namespace Role](#prometheus-per-namespace-role).
* What can the Metrics tell us:
    * `iptables` and / or `ipvs` sync information (~= how long does it take for Service changes to be reflected in the "routing" rules).
    * Kubernetes API Rest Client latency, requests and duration metrics (own requests made to the API).
    * Golang Process information (e.g., CPU, memory, GC status).

### SDN / CNI (e.g., Calico, Cilium)

Depends on the SDN / CNI used, if there are metrics available. Calico for example can expose metrics, but that must be enabled through a environemnt variable on the Calico Node DaemonSet.

For other SDNs, e.g., OpenVSwitch you may need to use an "external" exporter when available:

* https://github.com/digitalocean/openvswitch_exporter
* https://github.com/ovnworks/ovn_exporter

* What can the Metrics tell us:
    * Depending on the exporter, at least how much traffic is flowing and / or if there are issues with the daemon.

### The Nodes themself

#### node_exporter

See [Monitoring/Prometheus/Exporters - node_exporter](../../monitoring/prometheus/exporters/node_exporter.md).

#### ethtool_exporter

See [Monitoring/Prometheus/Exporters - ethtool_exporter](../../monitoring/prometheus/exporters/ethtool_exporter.md).

## Additional In-Cluster Components

Other components that are in and / or around a Kubernetes cluster.

### metrics-server (previously named heapster)

(More information https://kubernetes.io/docs/tasks/debug-application-cluster/resource-metrics-pipeline/)

* Summary: "How long do my Pods take to be scheudled?" (Hints at "you need to change your scheduler config")
* Port: `443/TCP`
* Path: `/metrics`
* Auth: None. (Recommendation: Add Kubernetes OAuth Proxy in front)
* What can the Metrics tell us:
    * Possibly metrics on how
    * Golang Process information (e.g., CPU, memory, GC status).

### kube-state-metrics

* Summary: "How long do my Pods take to be scheudled?" (Hints at "you need to change your scheduler config")
* Port: `8080/TCP` for "cluster" metrics and `8081/TCP` for kube-state-metrics metrics. (Recommended to scrape both)
* Path: `/metrics`
* Auth: ServiceAccount token.
    * Note(s):
        * RBAC ClusterRole needed, see [References Prometheus ClusterRole](#prometheus-clusterrole) and [References Prometheus Per-Namespace Role](#prometheus-per-namespace-role).
* What can the Metrics tell us:
    * Metrics about Deployments, StatefulSets, Jobs, CronJobs, and basically any other objects `Status` (that is in the official Kubernetes APIs).
    * Golang Process information (e.g., CPU, memory, GC status).

## Other Components

### Elasticsearch

Elasticsearch is not providing Prometheus metrics itself, but there is a well written exporter [GitHub justwatchcom/elasticsearch_exporter](https://github.com/justwatchcom/elasticsearch_exporter).
(There are some other exporters also available, though I have used mainly used this one for the amount of metrics I'm able to get from Elasticsearch with it)

* Summary: "Is my Elasticsearch able to ingest the amount of logs? Do I need to add more data nodes and / or resources?"
* Port: `9114/TCP` (depends on your installation)
* Path: `/metrics`
* Auth: ServiceAccount token
    * Note(s):
        * RBAC ClusterRole needed, see [References Prometheus ClusterRole](#prometheus-clusterrole) and [References Prometheus Per-Namespace Role](#prometheus-per-namespace-role).
* What can the Metrics tell us:
    * Elasticsearch cluster status.
        * Resources (CPU and Memory) and also Storage usage.
    * Elasticsearch Indices status (when enabled (can be filtered in different ways)).
    * Elasticsearch JVM info (GC, memory, etc).
    * Checkout the metrics list for a list of all Metrics available: https://github.com/justwatchcom/elasticsearch_exporter#metrics
    * Golang Process information (e.g., CPU, memory, GC status).

### Prometheus

* Summary: "Does my Prometheus have enough resources? Can I take in another X-thousand / million metrics?"
* Port: `9090/TCP` (depends on your installation)
* Path: `/metrics`
* Auth: None. (Recommendation: Add Kubernetes OAuth Proxy in front)
* What can the Metrics tell us:
    * Is my Prometheus doing "Okay", e.g., have enough resources
        * Can be used to see if the Prometheus is able to take in another X-thousand / million metrics.
    * Golang Process information (e.g., CPU, memory, GC status).

## References

### Prometheus ClusterRole

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: prometheus-infra
rules:
- apiGroups:
  - ""
  resources:
  - nodes/metrics
  verbs:
  - get
- nonResourceURLs:
  - /metrics
  - /metrics/cadvisor
  verbs:
  - get
```

### Prometheus Per-Namespace Role

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: prometheus
  namespace: YOUR_NAMESPACE
rules:
- apiGroups:
  - ""
  resources:
  - services
  - endpoints
  - pods
verbs:
- get
- list
- watch
```

### Prometheus Kubernetes ETCD Scrape Job Config

!!! info
    This selects the master Nodes based on the `node-role.kubernetes.io/master` label.
    So be sure to have it set on the master Nodes.

    For more information see [Kubernetes Cheat Sheet - Role Label for Node objects](../cheat-sheet.md#role-label-for-node-objects).

```yaml
TODO
```
