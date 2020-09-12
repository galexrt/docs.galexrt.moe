---
title: "kubeadm"
date: 2020-08-28
---

## System Preparations

```console
echo "br_netfilter" > /etc/modules-load.d/br_netfilter.conf
modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
```

## Container Runtime Install

```console
dnf module list cri-o
# Check if a CRI-O version with the same version as K8S is available, if not one version lower can also be okay.
dnf module enable cri-o:1.18 -y
dnf install -y cri-o

sed -i 's/^cgroup_manager =.*$/cgroup_manager = "systemd"/g' /etc/crio/crio.conf

rm -f /etc/cni/net.d/100-crio-bridge.conf /etc/cni/net.d/200-loopback.conf

systemctl enable crio
systemctl start crio
```

## Kubernetes Installation

```console
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet

```
