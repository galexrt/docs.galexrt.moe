---
title: "Switch Configuration"
---

## Basic Commands

* `enable` - Privileged mode.
* `configure terminal` - Enter global config mode
* `hostname NAME` - Set a hostname
* `configure terminal` - Enable config mode.
* `no ip domain lookup` - Disable accidental DNS lookup (in priv and non priv mode).
* `exit` - Go one mode back.

## Config Mode

Enter config mode using `configure terminal`.

* `line console 0` - Enter line `console 0` "interface".
* `interface Gi 0/48` - Enter Interface Gigabit 0/48 interface.
* `ip address IP_ADDR SUBNET_MASK` - Set IP_ADDR and the SUBNET_MASK for an interface.

## Make interface dedicated for mgmt

```console
configure terminal
interface Gi 0/48
no interface port
int vlan1
shutdown
exit
ip default-gateway DEFAULT_GATEWAY
```

## Set IP address on interface

```console
configure terminal
interface Gi 0/48
ip address IP_ADDR SUBNET_MASK
```

## "Activate" SSH RSA Key

```console
crypto key generate rsa general-keys modulus 4096 label sw-azubi-1
```

## Show interface status

```console
do show interface status
```

## Add passwords to console login thingy

```console
configure terminal
line console 0
password YOUR_PASSWORD
line vty 0 4
login
password YOUR_PASSWORD
exit
```

In the global config mode:

```console
enable secret YOUR_PASSWORD
```
