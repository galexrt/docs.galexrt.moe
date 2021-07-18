---
title: "Tips and Tricks"
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
