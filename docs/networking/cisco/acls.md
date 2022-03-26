---
title: "ACLs"
---

## ACLs

```console
# faculty auf faculty
access-list 100 permit tcp 172.17.10.0 0.0.0.255 172.17.0.0 0.0.255.255
access-list 100 permit udp 172.17.10.0 0.0.0.255 172.17.0.0 0.0.255.255
# Students auf http and https faculty
access-list 101 permit tcp 172.17.20.0 0.0.0.255 host 172.17.10.2 eq 80
access-list 101 permit tcp 172.17.20.0 0.0.0.255 host 172.17.10.2 eq 443
# Guests block all access
access-list 102 deny tcp 172.17.30.0 0.0.0.255 any
```

### Enter a "sub" interface

```console
ip access-group NUMBER in
```
