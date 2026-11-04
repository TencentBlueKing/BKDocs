# Terminology

## Host

The host is the host domain model in Node Manager. It carries CMDB host attributes (static attributes, such as host ID, internal IP, and business topology) and Node Manager runtime attributes (dynamic attributes, such as node role, status, version, and login information). Node Manager uses the CMDB host ID (`host_id`) as the primary key to identify a host.

## Node

A node is an object managed by Node Manager, around which lifecycle operations such as install, upgrade, reconfig, restart, and uninstall of Agent or Proxy are performed. Node roles (`node_role`) mainly include Agent and Proxy.

## Agent

The regular node role, carrying the GSE Agent capability on the target host. After the Agent is installed on a host, BlueKing can manage that host, including file distribution, job execution, data reporting, and basic information collection.

## Proxy

The node role for cross-network scenarios, carrying capabilities such as Agent control, file channel, data channel, and Relay service within its network unit. In a non-direct network unit, a Proxy must be installed before the hosts in that unit can be managed. For load balancing and disaster recovery, you can install multiple Proxies in one network unit.

## Relay

When managing nodes in a non-direct unit, Node Manager hosts a set of resident plugin services named `bk-nodemgr-relay` on Proxy nodes, providing node management capabilities for that unit (installation jump host, HTTP download, callback forwarding, etc.). The Relay communicates with the Proxy node's Agent via domain socket, relying on GSE's upstream/downstream signaling channels for cross-network communication.

## Network Area

A network area distinguishes the network scope to which hosts belong. It corresponds to the network area (also called cloud area) in CMDB, and the area ID is also used by GSE to identify the network a host belongs to. Different networks may use the same internal IP addresses; network areas distinguish these hosts and avoid confusion based on IP alone. The area with ID `0` is the default network area.

## Network Unit

A network unit is the basic proxy-management unit of Node Manager, organizing a group of nodes managed through the same access method. Each unit belongs to a network area and determines whether its Agents connect directly to GSE (direct unit) or connect upstream through the unit's Proxy (non-direct unit). **Areas describe network ownership; units describe management paths.**

## Access Point

An access point is a named set of GSE access addresses (cluster signaling channel, file channel, data channel), configured on a network unit for Proxies of other network units to connect to. An access point is address configuration — not a Proxy, nor an additionally deployed service.

## Plugin Package / Plugin / Process

- **Plugin Package (Package)**: A static resource with an explicit version, shared globally.
- **Plugin**: A business concept, isolated per tenant, unique within the same tenant, and does not carry a version itself.
- **Process**: A running instance of a plugin on a host, with a lifecycle (created → running → stopped/destroyed). Each plugin can have only one process instance per host.

Plugins are sub-programs or scripts scheduled by the GSE Agent. You can use the plugin development framework to build custom plugins and deploy them to hosts through Node Manager, extending management capabilities with business-specific features.

## Deploy Policy

A deploy policy declaratively defines the desired deployment state of plugins on target nodes, consisting of a scope and a spec. Nodes covered by the scope are automatically deployed according to the rules defined by the policy.
