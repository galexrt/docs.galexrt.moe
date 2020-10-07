---
title: "Tips and Tricks"
date: 2020-01-25
---

## kubectl: Context Switching

### Switch Namespace

```console
kubectl config set-context --current --namespace NAMESPACE
```

### Switch Context

```console
kubectl config use-context CONTEXT_NAME
```

### Show Contexts

```console
kubectl config get-contexts
```
