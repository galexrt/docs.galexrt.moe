---
title: "Example Configs"
---

## VLANs + VLAN Ingress Filtering

```console
/interface bridge
# DO NOT SET `vlan-filtering=yes` here already! Otherwise you would lock yourself out.
add dhcp-snooping=yes frame-types=admit-only-vlan-tagged igmp-snooping=yes ingress-filtering=no name=bridge1 pvid=4094 vlan-filtering=no
/interface vlan
add interface=bridge1 name=vlan_10_misc vlan-id=10
add interface=bridge1 name=vlan_20_seccam vlan-id=20
add interface=bridge1 name=vlan_30_iot vlan-id=30
add interface=bridge1 name=vlan_100_guest vlan-id=100
add interface=bridge1 name=vlan_4093_admin vlan-id=4093
add interface=bridge1 name=vlan_4094_netmgmt vlan-id=4094
/interface bridge port
add bridge=bridge1 frame-types=admit-only-vlan-tagged hw=yes ingress-filtering=yes interface=bonding1 pvid=4094 trusted=yes
add bridge=bridge1 frame-types=admit-only-vlan-tagged hw=yes ingress-filtering=yes interface=sfp-sfpplus1 pvid=4094 trusted=yes
add bridge=bridge1 frame-types=admit-only-vlan-tagged hw=yes ingress-filtering=yes interface=sfp-sfpplus2 pvid=4094 trusted=yes
add bridge=bridge1 frame-types=admit-only-vlan-tagged hw=yes ingress-filtering=yes interface=sfp-sfpplus3 pvid=4094 trusted=yes
add bridge=bridge1 frame-types=admit-only-untagged-and-priority-tagged hw=yes ingress-filtering=yes interface=sfp-sfpplus4 pvid=10
add bridge=bridge1 frame-types=admit-only-untagged-and-priority-tagged hw=yes ingress-filtering=yes interface=sfp-sfpplus5 pvid=4093
add bridge=bridge1 frame-types=admit-only-vlan-tagged hw=yes ingress-filtering=yes interface=sfp-sfpplus6 pvid=4094 trusted=yes
/interface bridge vlan
add bridge=bridge1 tagged=bonding1,sfp-sfpplus1,sfp-sfpplus6 untagged=sfp-sfpplus4 vlan-ids=10
add bridge=bridge1 tagged=bonding1,sfp-sfpplus1,sfp-sfpplus6 vlan-ids=20
add bridge=bridge1 tagged=bonding1,sfp-sfpplus1,sfp-sfpplus6 vlan-ids=30
add bridge=bridge1 tagged=bonding1,sfp-sfpplus1,sfp-sfpplus6 vlan-ids=100
add bridge=bridge1 tagged=bonding1,sfp-sfpplus1,sfp-sfpplus2,sfp-sfpplus3,sfp-sfpplus6 untagged=sfp-sfpplus5 vlan-ids=4093
add bridge=bridge1 tagged=bonding1,bridge1,sfp-sfpplus1,sfp-sfpplus2,sfp-sfpplus3,sfp-sfpplus6 vlan-ids=4094
# Get an IP for the network management interface
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface=vlan_4094_netmgmt
# Wait for everything to "settle down"
:delay 3
# Enable VLAN Filtering
/interface bridge
set bridge1 ingress-filtering=yes vlan-filtering=yes
```

### Hardware Offloading (`hw=yes`)

It depends on the Router OS version and if the Switch Chip in your MikroTik device supports hardware offloading.

See [MikroTik Wiki - Manual:Switch Chip Features](https://wiki.mikrotik.com/wiki/Manual:Switch_Chip_Features).

## Bonding

This bonds interfaces `sfp-sfpplus7` and `sfp-sfpplus8` together as `bonding1` interface:

```console
/interface bonding
add lacp-rate=1sec name=bonding1 slaves=sfp-sfpplus7,sfp-sfpplus8 transmit-hash-policy=layer-2-and-3
```
