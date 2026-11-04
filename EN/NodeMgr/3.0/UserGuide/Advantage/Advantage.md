# Features and Advantages

## Cloud-Native Microservices Architecture

The service layer consists of three basic modules — Application, Backend, and File — all stateless and horizontally scalable. It supports deployment on the BlueKing PaaS platform, or directly via Helm / docker-compose, and supports rolling updates and graceful shutdown to ensure lossless upgrades.

## Flexible Cross-Network Management

A three-layer topology model of "Network Area + Network Unit + Access Point" flexibly describes network environments: areas describe network ownership, units describe management paths (direct / via Proxy), and access points describe the connection addresses between units. It supports multi-level Proxy bridging across multiple network areas and multi-access-point management.

## Diverse Installation Methods

- **Online automatic installation**: Backend or Relay logs in to the target host via SSH/WMI to trigger installation; file transfer and status write-back channels are automatically selected based on topology.
- **Manual installation**: Backend generates a bootstrap command, and the administrator runs it manually on the target host.
- **Offline installation**: For environments completely unable to access the management network, the administrator manually downloads the offline package and performs the installation (applies to Proxy).

## Declarative Plugin Deploy Policy

Deploy policies declaratively define the desired state of plugins on target nodes: install when expected but absent, upgrade when versions mismatch, and uninstall when no longer part of the expected set. Scopes support dynamic topology, set templates, service templates, instances, dynamic groups, and more.

## Flexible Configuration Policies

Supports Agent configuration policies, Proxy configuration policies, and plugin configuration policies. Node configurations can be customized and orchestrated under multiple conditions, and configuration changes take effect through Reconfig without reinstalling nodes.

## Real-Time Task Logs

Tasks such as install and upgrade run asynchronously. The task history shows the execution status and logs of each sub-task in real time, making it easy to locate problems.

## Multiple Operating Systems

**Linux hosts**: Supports mainstream Linux distributions, including but not limited to CentOS, Ubuntu, SuSE, and Debian.

**Windows hosts**: Supports Windows Server series.

**macOS hosts**: Supports Darwin (macOS).

> The supported OS range is subject to the entries actually configured in `gseDeployConfs` on the backend. The official defaults provide linux / windows / darwin.
