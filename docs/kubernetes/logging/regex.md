---
title: "Regex"
---

!!! info
    In general make sure to forward the audit logs to your log store of choice.

    Kubernetes docs: [https://kubernetes.io/docs/tasks/debug-application-cluster/audit/](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/)

***

Some neat regex to parse certain messages from Kubernetes logs.

## `RBAC DENY` Messages

Good to setup some log alerting on those messages to make sure the applications are not hammering the API servers with "bad" RBAC.

Match message (should be enough for matching):
```shell
\] RBAC DENY:
```

Rewriting into a comma separated list + showing occurence counts:
```shell
perl -n -e'/\] RBAC DENY: user "(.+)" groups \[(".+")\] cannot "([a-zA-Z]+)" resource "([a-zA-Z._-]+)" in namespace "([a-zA-Z-_]+)"/ && print "ns=$5,verb=$3,resource=$4,user=$1,groups=$2\n"' | sort | uniq -c
```
