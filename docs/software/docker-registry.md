---
title: "Docker Registry"
date: 2020-08-28
---

## Garbage Collection doesn't work with non AWS S3 stores

(Non AWS S3 stores, e.g., Ceph RGW, Minio, Linode Object store and other similar stores)

This is due to [GitHub docker/distribution - Issue `failed to garbage collect` #3200](https://github.com/docker/distribution/issues/3200).

!!! note
    This workaround / "fix" is based on [@thomasf (Thomas Frössman)](https://github.com/thomasf)'s [comment in the issue](https://github.com/docker/distribution/issues/3200#issuecomment-671062638).

There is an issue in the `s3aws.Walk()` function which fails for (most) non AWS S3 storages.

To make the garbage collection work, an empty file needs to be created in the bucket at the following path (default S3 bucket settings used in the docker-registry itself) `BUCKET_NAME/docker/registry/v2/repositories/`.

!!! info
    Replace the placeholders (`MC_HOST_CONFIG_NAME`, `BUCKET_NAME`) according to your docker-registry S3 storage configuration.

Using the Minio client `mc` (compatible with most / all S3 based storages) the following command should "fix" the issue:

```console
# Create empty file
touch workaround_s3aws_walk_issue_github_docker_distribtuion_issue_3200
# Upload the empty file
mc cp workaround_s3aws_walk_issue_github_docker_distribtuion_issue_3200 MC_HOST_CONFIG_NAME/BUCKET_NAME/docker/registry/v2/repositories/
# Verify that the file has been uploaded
mc ls MC_HOST_CONFIG_NAME/BUCKET_NAME/docker/registry/v2/repositories/
```

## Configuration through Environment Variables Fails

Sometimes when "deeply nesting" environment variables to configure a certain aspect of the docker-registry configuration, e.g., `REGISTRY_STORAGE_MAINTENANCE_READONLY_ENABLED`, need to be specified as YAML or JSON starting from "a few levels" further below of the config structure:

```yaml
REGISTRY_STORAGE_MAINTENANCE: |-
  uploadpurging:
    enabled: false
```

This has been posted for a similar config situation by [@0rax](https://github.com/0rax) in [GitHub docker/distribution - Registry - Upload purging environment overrides crash registry at startup Issue #1736](https://github.com/docker/distribution/issues/1736#issuecomment-435362014).
