# Product Overview

BlueKing Node Manager (bk-nodemgr) is the next-generation host node management service of the BlueKing ecosystem (Node Manager V3), rebuilt on a Go microservices architecture. It provides full lifecycle control for GSE Agents on managed nodes — install, upgrade, reconfig, restart, and uninstall.

Node Manager supports automated deployment on common Linux, Windows, and macOS (Darwin) operating systems, and provides a cross-network management solution through the "Network Area + Network Unit + Access Point" topology model: for network-isolated areas, you only need to deploy Proxy nodes in the target area to bridge and manage the hosts within it, helping enterprises easily handle IaaS device management across multiple network areas.

## Core Features

- **Network Area Management**: Flexibly divide network units, support multi-level Proxy bridging across multiple network areas, and manage multiple access points.
- **Node Management**: Provides a full set of control services for GSE Agents on managed nodes, including install, upgrade, reconfig, restart, and uninstall.
- **Policy Management**: Supports flexible configuration policies, offering custom GSE Agent configuration combinations and orchestration under multiple conditions.
- **Plugin Management**: Supports basic plugin operations and deploy policies, enabling plugin lifecycle control across large-scale nodes.
- **Package Management**: Supports version management and control of GSE Agent / Proxy / Plugin packages.
