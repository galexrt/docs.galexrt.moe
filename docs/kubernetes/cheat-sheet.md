---
title: "Cheat Sheet"
date: 2018-05-16
---

## Quickly trigger Rolling Update of Deployment, StatefulSet, DaemonSet, etc

```shell
kubectl patch -n kube-system ds kube-proxy -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"$(date +'%s')\"}}}}}"
```

Running `kubectl replace`/`kubectl apply` on an object which the command above was used on, will always trigger a rolling update again. This is due to the change to the annotations.

## Debug Pod manifest to "escape" to the node

_The Pods manifest assumes that you are allowed to run `privileged` Pods in your cluster.
If you are using you may need to set a ServiceAccount which is allowed "all the things" (e.g. `privileged`, `hostNetwork`, and so on)._

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: debug-pod
  labels:
    app: debug
spec:
  hostNetwork: true
  tolerations:
    - key: node-role.kubernetes.io/master
      effect: NoSchedule
    - key: "CriticalAddonsOnly"
      operator: "Exists"
  restartPolicy: Never
  hostIPC: true
  hostPID: true
#  nodeName: SPECIFIC_TARGET_NODE
  priorityClassName: "system-cluster-critical"
  containers:
  - name: debug-pod
    image: busybox
    command: ["/bin/sleep", "36000"]
    securityContext:
      privileged: true
      allowPrivilegeEscalation: true
```

`kubectl exec -it POD_NAME -- sh` into the Pod and use `nsenter` to escape the container's namespace:

```console 
$ nsenter -t 1 -m -u -n -i sh
```

## Role Label for Node objects

The `node-role.kubernetes.io/` can take "anything" as a role.
Meaning that `node-role.kubernetes.io/my-cool-role` (any value) will cause the `kubectl get nodes` output to display `my-cool-role` (and other such role labels) as the Node role.
