---
title: "Explained"
date: 2018-05-17
dscription: "Kubernetes Networking Explained"
---

## Assumptions

* Basic network knowledge (e.g. CIDR, Source and Destination NAT)
* Basic `iptables` knowledge
* Pod/Cluster CIDR: `100.64.0.0/13`
    * Every node gets a `/24` `podCIDR`.
* Service IP CIDR: `100.72.0.0/16`
* Node IP CIDR: `10.10.10.0/24`

More info on IP Classless Inter-Domain Routing (short CIDR):

* [IPv4 Classless Inter-Domain Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#IPv4_CIDR_blocks)
* [IPv6 Classless Inter-Domain Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#IPv6_CIDR_blocks)

_The source for the diagrams, can be found as `.graphml` at the same path as the images._

**Example**: `kubernetes-networking-explained-network_stack.svg` -> `kubernetes-networking-explained-network_stack.graphml`

## Network Stack

<figure>
  <img src="kubernetes-networking-explained-network_stack.svg" />
  <figcaption>Network Overview caption</figcaption>
</figure>

## Traffic Flow

### Pod to Pod

<figure>
  <img src="kubernetes-networking-explained-traffic_flow-pod_to_pod.svg" />
  <figcaption>Pod to Pod Traffic</figcaption>
</figure>

### Pod to Service IP

<figure>
  <img src="kubernetes-networking-explained-traffic_flow-pod_to_service_ip.svg" />
  <figcaption>Pod to Service IP</figcaption>
</figure>

#### Service IP iptables

<figure>
  <img src="kubernetes-networking-explained-service-ip-iptables-flow.svg" />
  <figcaption>Service IP iptables</figcaption>
</figure>

### NodePort to Service IP to Pod

<figure>
  <img src="kubernetes-networking-explained-nodeport_to_pod.svg" />
  <figcaption>NodePort to Service IP to Pod</figcaption>
</figure>
