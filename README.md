# Prometheus Process Exporter

* Installs prometheus [process exporter](https://github.com/ncabatoff/process-exporter)

## TL;DR;

```console
$ helm repo add prometheus-process-exporter-charts https://raw.githubusercontent.com/mumoshu/prometheus-process-exporter/master/docs
$ helm install --name process-exporter prometheus-process-exporter-charts/prometheus-process-exporter
```

## Introduction

This chart bootstraps a prometheus [process exporter](https://github.com/ncabatoff/process-exporter) daemonset on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name process-exporter prometheus-process-exporter-charts/prometheus-process-exporter
```

The command deploys process exporter on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the process exporter chart and their default values.

|             Parameter               |                                                          Description                                                          |                 Default                 |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| `image.repository`                  | Image repository                                                                                                              | `ncabatoff/process-exporter`            |
| `image.tag`                         | Image tag                                                                                                                     | `0.5.0`                                 |
| `image.pullPolicy`                  | Image pull policy                                                                                                             | `IfNotPresent`                          |
| `groups`                            | [Entries of `process_names:` in the process-expoter config](https://github.com/ncabatoff/process-exporter/tree/master#using-a-config-file) | `{"groups": [{"comm": ["chronyd"]}, {"comm": ["bash"]}, {"comm": ["rsync"]}, {"comm": ["scp"]}, {"comm": ["ssh"]}]` |
| `extraArgs`                         | Additional container arguments                                                                                                | `[]`                                    |
| `extraHostVolumeMounts`             | Additional host volume mounts                                                                                                 | {}                                      |
| `podLabels`                         | Additional labels to be added to pods                                                                                         | {}                                      |
| `podAnnotations`                    | Additional annotations to be added to pods                                                                                    | {}                                      |
| `rbac.create`                       | If true, create & use RBAC resources                                                                                          | `true`                                  |
| `rbac.pspEnabled`                   | Specifies whether a PodSecurityPolicy should be created.                                                                      | `true`                                  |
| `hostNetwork`                       | Whether to enable hostNetwork on the DaemonSet                                                                                | `false`                                 |
| `resources`                         | CPU/Memory resource requests/limits                                                                                           | `{}`                                    |
| `service.type`                      | Service type                                                                                                                  | `ClusterIP`                             |
| `service.port`                      | The service port                                                                                                              | `9100`                                  |
| `service.targetPort`                | The target port of the container                                                                                              | `9100`                                  |
| `service.nodePort`                  | The node port of the service                                                                                                  |                                         |
| `service.annotations`               | Kubernetes service annotations                                                                                                | `{prometheus.io/scrape: "true"}`        |
| `serviceAccount.create`             | Specifies whether a service account should be created.                                                                        | `true`                                  |
| `serviceAccount.name`               | Service account to be used. If not set and `serviceAccount.create` is `true`, a name is generated using the fullname template |                                         |
| `serviceAccount.imagePullSecrets`   | Specify image pull secrets                                                                                                    | `[]`                                    |
| `serviceMonitor.enabled`            | if `true`, creates a Prometheus Operator ServiceMonitor                                                                       | `false`                                 |
| `serviceMonitor.labels`             | Set of labels to apply on ServiceMonitor                                                                                      | `{}`                                    |
| `serviceMonitor.interval`           | Set custom metric scraping interval ServiceMonitor, must be string                                                            | `10s`                                   |
| `securityContext`                   | SecurityContext                                                                                                               | `{"runAsNonRoot": true, "runAsUser": 65534}` |
| `affinity`                          | A group of affinity scheduling rules for pod assignment                                                                       | `{}`                                    |
| `nodeSelector`                      | Node labels for pod assignment                                                                                                | `{}`                                    |
| `tolerations`                       | List of node taints to tolerate                                                                                               | `- effect: NoSchedule operator: Exists` |
| `priorityClassName`                 | Name of Priority Class to assign pods                                                                                         | `nil`                                   |
| `endpoints`                         | list of addresses that have process exporter deployed outside of the cluster                                                  | `[]`                                    |
| `livenessProbe.initialDelaySeconds` | Amount of seconds to wait before the first probe                                                                              | `20`                                    |
| `livenessProbe.periodSeconds`       | Amount of seconds between the probes                                                                                          | `10`                                    |
| `livenessProbe.failureThreshold`    | Amount of probe failures before the pod is restared                                                                           | `3`                                     |
| `livenessProbe.successThreshold`    | Amount of consecutive probe successes to mark the pod as healthy                                                              | `1`                                     |
| `readinessProbe.initialDelaySeconds`| Amount of seconds to wait before the first probe                                                                              | `20`                                    |
| `readinessProbe.periodSeconds`      | Amount of seconds between the probes                                                                                          | `10`                                    |
| `readinessProbe.failureThreshold`   | Amount of probe failures before the pod is restared                                                                           | `3`                                     |
| `readinessProbe.successThreshold`   | Amount of consecutive probe successes to mark the pod as ready                                                                | `1`                                     |
| `updateStrategy`  | Update strategy for the daemonset   |   `Rolling update with 1 max unavailable` |
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set serviceAccount.name=process-exporter  \
    stable/prometheus-process-exporter
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml stable/prometheus-process-exporter
```

## Releasing a new version of this chart

```console
$ git tag prometheus-process-exporter-${CHART_VERSION}
$ make upload
$ make index
```
