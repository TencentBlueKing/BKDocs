# Which Ports Need to Be Opened to Install Proxy

The network connectivity required for installing and running a Proxy falls into three directions. Specific ports are subject to the actual configuration of GSE services and Node Manager services in your environment:

## 1. Installation Source → Proxy Host

- SSH login port (default 22): during online automatic installation, the installation source (Server or upstream Relay) needs to log in to the Proxy host via SSH/SFTP to trigger installation and transfer files.

## 2. Proxy → Upstream Access Point

The Proxy needs to access the three channel address groups of the upstream access point selected by its network unit:

- `cluster`: the GSE signaling channel, carrying signaling between nodes and upstream;
- `file`: the GSE file channel, carrying file transfers between units;
- `data`: the GSE data channel, carrying node data reporting.

Each channel group can have multiple addresses; ports are subject to the actual GSE / upstream Proxy service configuration.

## 3. Agents in the Unit → Proxy

- Relay `download` port: nodes in the unit pull installation packages from the Relay plugin on the Proxy;
- Relay `callback` port: nodes in the unit write back execution status to the Relay plugin;
- The address and port exposed by the GSE Proxy to downstream Agents on the Proxy's service IP (`advertise_ip`, treated as the internal IP when not set).

> The Relay plugin listens on the Proxy's **first internal IP**; when installing, make sure this address is a real internal address reachable by nodes in the same unit. Agents in a direct unit need to access the Node Manager Backend `callback` port (default 28103) and the File download service port.

Port direction diagram:

```text
                        ┌──────────────────────────────────┐
                        │  BlueKing Management Plane        │
                        │  (Node Manager Server)            │
                        │  Backend callback / File download │
                        └──────────────▲───────────────────┘
                                       │ (2) Proxy → upstream access point
                                       │     cluster (signaling) / file / data
┌────────────────┐  (1) source → Proxy │
│ Installation    │ ──────────────────▶│
│ source: Server  │   SSH (default 22) │
│ or upstream     │            ┌───────┴───────┐
│ Relay           │            │ Proxy node    │
└────────────────┘            │ Relay plugin  │
                              └───────▲───────┘
                                      │ (3) Agents in unit → Proxy
                                      │     Relay download / callback
                              ┌───────┴───────┐
                              │ Agents in unit│
                              └───────────────┘
```
