---
title: "Cloudflare"
date: 2020-01-31
---

## Create IPv4 and IPv6 IPSets

```console
# Create ipsets for IPv4 and IPv6
ipset create cf4 hash:net family inet
ipset create cf6 hash:net family inet6
# Create ipset for both lists, so both IP versions can use the same list name `cf`
ipset create cf list:set cf4 cf6
# Get the current Cloudflare IP lists
for ip in $(curl https://www.cloudflare.com/ips-v4); do
    ipset add cf4 "$ip";
done
for ip in $(curl https://www.cloudflare.com/ips-v6); do
    ipset add cf6 "$ip";
done
```

### Allow `80/tcp` (http) and `443/tcp` (https) Access to Cloudflare IPs only

!!! note
    These iptables rules are for a stateful firewall!

```console
iptables -A INPUT -m set --match-set cf4 src -p tcp -m multiport --dports http,https -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports http,https  -m state --state NEW -j DROP
ip6tables -A INPUT -m set --match-set cf6 src -p tcp -m multiport --dports http,https -m state --state NEW -j ACCEPT
ip6tables -A INPUT -p tcp -m multiport --dports http,https  -m state --state NEW -j DROP
```
