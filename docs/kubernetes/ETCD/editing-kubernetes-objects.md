---
title: "Editing Kubernetes Objects"
date: 2019-03-22
---

!!! danger
    You should be 100% sure what you are doing and should have at least a snapshot of the etcd you want to edit as things can and will possibly go wrong!

    Do this at your own risk!

## Requirements

* ETCD cluster running.
    * `etcdctl` can reach it (you need to know which flags to provide, e.g., for tls certs and so on).
* Golang installed (`glide` installed in `PATH`, e.g., `go get -u github.com/Masterminds/glide`).
    * PATH includes the `$GOPATH/bin` (`export PATH="$GOPATH/bin/:$PATH"`)

## Steps

### Step 1 - Prepare Environment

```bash
go get -u github.com/jpbetz/auger
cd $GOPATH/src/github.com/jpbetz/auger
go get -u github.com/Masterminds/glide
make vendor
# Stay in this directory
```

!!! warning
    Be sure to stop all API servers, before continuing with the next steps.
    Be sure to stop all Controller Manager servers, before continuing with the next steps.

    Depending on the cluster setup, you may just need move out the according `manifest` from `/etc/kubernetes/manifests` directory.

### Step 2 - Locate object path

!!! note
    The `etcdctl` probably needs to be run inside the etcd container on one of the Kubernetes masters.

```bash
ETCDCTL_API=3 etcdctl \
    get /registry/ --keys-only --prefix
```

I recommend you to keep the session on the server for `etcdctl` open and after finding the correct key to export it using `export YOUR_OBJECT_PATH=__PATH__` as it will be used like this later on.

### Step 3 - Get object from ETCD

!!! note
    The `etcdctl` probably needs to be run inside the etcd container on one of the Kubernetes masters.

Replace `$YOUR_OBJECT_PATH` with the path of the object or set it as a variable.

```bash
ETCDCTL_API=3 etcdctl \
    --endpoints=https://[127.0.0.1]:2379 \
    --cacert=/var/lib/minikube/certs//etcd/ca.crt \
    --cert=/var/lib/minikube/certs//etcd/healthcheck-client.crt \
    --key=/var/lib/minikube/certs//etcd/healthcheck-client.key \
    get $YOUR_OBJECT_PATH > etcd-data-old.bin
```

Copy `etcd-data-old.bin` to the host, e.g.:

```bash
scp $SSH_USER@$SSH_HOST:etcd-data-old.bin .
```

### Step 4 - Decode and edit the produced output as you need

```bash
cat etcd-data-old.bin | \
    go run main.go decode > object.yaml
```

Now edit the `object.yaml` as you need.

### Step 5 - Encode and save data to ETCD

```bash
cat object.yaml | \
    go run main.go encode > etcd-data-new.bin
```

Copy the `etcd-data-new.bin` to the host, e.g.:

```bash
scp etcd-data-new.bin $SSH_USER@$SSH_HOST:
```

!!! note
    The `etcdctl` probably needs to be run inside the etcd container on one of the Kubernetes masters.

```bash
cat etcd-data-new.bin | \
    ETCDCTL_API=3 etcdctl \
    --endpoints=https://[127.0.0.1]:2379 \
    --cacert=/var/lib/minikube/certs//etcd/ca.crt \
    --cert=/var/lib/minikube/certs//etcd/healthcheck-client.crt \
    --key=/var/lib/minikube/certs//etcd/healthcheck-client.key \
    put $YOUR_OBJECT_PATH
```

### Step 6 - Verify the object is valid for Kubernetes

Just run `kubectl get OBJECT_KIND OBJECT_NAME -o yaml` on the object you just edited to ensure it is still in working order.

If it returns the objects YAML, you are fine. **In case of errors, such as `illegal bytes` or so, you should restore a backup ASAP!**
