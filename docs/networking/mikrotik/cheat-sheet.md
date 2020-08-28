---
title: "Cheat Sheet"
date: 2020-01-25
---
## Quick Run Snippets

### Automatic OS and Firmware Update

```shell
/system routerboard settings set auto-upgrade=yes
/system package update
check-for-updates once
:delay 3s;
:if ( [get status] = "New version is available") do={ install }
:delay 1s:
/system routerboard upgrade
/system reboot
```

## Config

### Set Hostname / Identity

```shell
/system identity
set name=HOSTNAME
```

### Set Timezone

To `Europe/Berlin`.

```shell
/system clock
set time-zone-name=Europe/Berlin
```

### Disable Ports beginning with `ether`

```shell
:foreach i in=[/interface find name~"ether"] do={ /interface ethernet set $i disabled=yes }
```

### "Advertise" 10G on SFP+ Ports

```shell
:foreach i in=[/interface find name~"sfp-sfpplus"] do={ /interface ethernet set $i advertise=10000M-full; }
```

### Enable Graphs / Graphing

```shell
/tool graphing
set page-refresh=240
/tool graphing interface
add
/tool graphing resource
# Put your admin / configuration network here
add allow-address=172.16.0.0/24
```

### Set Boot target of Device

```shell
/system routerboard settings
set boot-os=router-os
```
