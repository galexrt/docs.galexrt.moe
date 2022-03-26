---
title: "Cheat Sheet"
---

## Update StatefulSet `volumeClaimTemplates` And Other Uneditable Sections

1. Get the latest YAML of the StatefulSet you want to update (e.g., change size of a `volumeClaimTemplates` entry).
2. Make the changes to the YAML file.
3. Run `kubectl delete statefulset STATEFULSET_NAME --cascade=orphan`
   1. The important thing here is the `--cascade=orphan` flag, it stops the `ControllerRevisions` objects (+ the Pods) to **not be deleted** (no downtime).
4. Now just apply your StatefulSet YAML and if needed trigger a rolling update of the StatefulSet using the `kubectl rollout restart statefulset STATEFULSET_NAME` command.

## Quickly trigger Rolling Update of Deployment, StatefulSet, DaemonSet, etc

### New Way

Example for `StatefulSet` and `Deployment` below:

```console
kubectl rollout restart statefulset STATEFULSET_NAME
kubectl rollout restart deployment DEPLOYMENT_NAME
```

### Old Way

```console
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

## kubectl: Config/ Context Switching

### Set Namespace For Current Context

```console
kubectl config set-context --current --namespace NAMESPACE
```

### Switch To Other Context

```console
kubectl config use-context CONTEXT_NAME
```

### Show Contexts

```console
kubectl config get-contexts
```


## Trigger/ Run A CronJob Now (Manually)

```console
kubectl create job --from=cronjob/CRONJOB_NAME JOB_NAME
kubectl create job --from=cronjob/curator curator-manual-run
```
