---
title: "Kubernetes Name Schemas"
date: 2019-06-16
---

## Hostname Schema

### Domain TLD Usage

* Services: `example.services`
* Servers (bare metal, VMs, doesn't matter): `example.systems`
* Network hardware: `example.network`

### Schema Parts

* `COUNTRY` - ISO 3166-1 alpha-3 code, see [ISO 3166-1 alpha-3 - Wikipedia](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) and [Online Browsing Platform (OBP) - ISO](https://www.iso.org/obp/ui/#search).
* `PROVIDER` - 3 character long abbreviation of provider name.
* `DC` - Optional info about datacenter/region (e.g., `FSN1-DC1`).
* `CLUSTER` - Cluster designation (in case of Kubernetes, should always have k8s in the beginning) and if there can be multiple a number added (with two digits, e.g., `01`, `12`).
* `ROLE` - In case of Kubernetes, e.g., `master`, `etcd`, `node` (other "special" roles could be, e.g., `ingress`, `stora` (could have a suffix per storage software, e.g. `storaceph`)).
* `COUNT_OR_ID` - A count is a special "type". It can for servers that are known to have only a maximum of n machines at maximum, the number of servers padded with zeroes (e.g., max 12 servers results in `COUNT` for the third machine being `03`), in case of nodes where there can be an undefined amount of them it should be a shortid.
    * To generate a "random" ID (**requires [`bashids`](https://github.com/benwilber/bashids) to be installed**):
      ```console
      bashids \
        -e \
        -s 'B_r1KMOASvn_5A1hDKCdPXJfrIBcddpwOnT5orXYaQPV4Ixb1zNSpa-nF6HOw8mii3pqovZUtsnGZ5pqbf59wPfeMp9XagGXc8ViJreL_5J1kvSnDCPfqvuV2bmGsx4DrVV_ef3Gr3MgCMrX86TGUjCDeJmM3LONAfKIH_vv0ZR9WWcJJbLCc5xnxWh7Is8qNq95ORIHS6iU4gKZNV-LIxdYxd7WyO2fKeOn8kApv0FFD2ydkJXdz4KjqBEcN5Fu' \
        $(date +%s%6N) | \
          tr '[:upper:]' '[:lower:]'
      ```

### Servers / VMs Schema

```bash
# When country, provider and dc should be omited:
{CLUSTER}-{ROLE}-{COUNT_OR_ID}.example.systems
# Examples:
## Master / Primary Kubernetes node
k8s02-master-01.example.systems
## Node / Worker Kubernetes node
k8s02-node-4ua16bzb6r7.example.systems

# With country, provider and dc in the name:
{CLUSTER}-{ROLE}-{COUNT_OR_ID}-{PROVIDER}-{COUNTRY}{DC}.example.systems
# Examples:
## `deu-fsn1dc1` translates to Germany, FSN1-DC14 (Falkenstein)
k8s02-master-01-htz-deu-fsn1dc14.example.systems
## `deu-fsn1dc1` translates to Germany, FSN1-DC1 (Falkenstein)
k8s02-node-4ua16bzb6r7-htz-deu-fsn1dc1.example.systems
## `eee-west2` translates to GCP Region `europe-west2`
k8s02-master-02-gcp-eee-west2.example.systems
## `usa-west1` translates to AWS Region `us-west1`
k8s02-node-7ca16bnb2r1-aws-usa-west1.example.systems
```

#### Script: Gernate Hostname (+ ID)

```bash
CLUSTER="k8s02"
ROLE="node"
COUNT_OR_ID="$(sleep 0.00001; \
bashids \
    -e \
    -s 'B_r1KMOASvn_5A1hDKCdPXJfrIBcddpwOnT5orXYaQPV4Ixb1zNSpa-nF6HOw8mii3pqovZUtsnGZ5pqbf59wPfeMp9XagGXc8ViJreL_5J1kvSnDCPfqvuV2bmGsx4DrVV_ef3Gr3MgCMrX86TGUjCDeJmM3LONAfKIH_vv0ZR9WWcJJbLCc5xnxWh7Is8qNq95ORIHS6iU4gKZNV-LIxdYxd7WyO2fKeOn8kApv0FFD2ydkJXdz4KjqBEcN5Fu' \
    $(date +%s%6N) | \
        tr '[:upper:]' '[:lower:]')"
echo "$CLUSTER-$ROLE-$COUNT_OR_ID.example.systems"
echo "$CLUSTER-$ROLE-$COUNT_OR_ID-htz-deu-fsn1dc1.example.systems"
```

!!! note
    The `sleep 0.00001` is used to try to prevent "duplicates" when `bashids` is run in parallel to generate IDs.

## Services Schema

```ini
{CLUSTER}-({OWNER}-){ROLE}.example.services

# Examples
## Kubernetes cluster "k8s02" Loadbalancer owned by the "system"
k8s02-system-lb.example.services
# or the owner can be omitted in such cases
k8s02-lb.example.services
## Kubernetes cluster "k8s02" hosted TeamSpeak service owned by customer "gamer"
k8s02-gamer-ts3.example.services
```
