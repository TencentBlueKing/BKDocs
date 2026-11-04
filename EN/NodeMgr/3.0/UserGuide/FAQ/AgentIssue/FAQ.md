# Agent FAQ

## What are the prerequisites for installing an Agent?

- Direct unit: the target host's SSH (Linux/macOS) or WMI (Windows) channel is available; the host can access the `download` address of the Node Manager File service and the `callback` address of Backend; the host can access the GSE addresses in the unit's direct configuration.
- Non-direct unit: the target host can access the unit's Proxy; a Proxy in the unit has installation capability and the Relay plugin is running properly.

If online installation conditions are not met, you can use **manual installation** instead: the system generates a bootstrap command that you copy to the target host and run manually.

## What should I do if installation reports that a host already exists?

Node Manager validates host uniqueness by "network area + internal IP". If a host is reported as existing, that combination already has a record in BlueKing, and the installer will skip those hosts. To reinstall, uninstall or remove the existing host first.

## Why do nodes still use old configuration after I changed the unit's direct addresses or access points?

After changing direct addresses, upstream selections, or access point configurations, existing nodes are not updated immediately. You need to perform a **Reconfig** on the corresponding Agents or Proxies. Reconfig restarts the node service — schedule it at an appropriate time and confirm the task succeeded in Task History.
