# Common Errors When Installing Agent

When an installation task fails, first open "Task History", click the failed host to view the sub-task execution log, and then troubleshoot against the following common scenarios.

## Scenario 1: Target host cannot download the installation package or write back status

Symptom: installation package download or status callback steps time out or fail to connect in the log.

Troubleshooting:

- For hosts in a direct unit, confirm they can access the File service's `download` address and Backend's `callback` address;
- For hosts in a non-direct unit, confirm they can access the Relay plugin's `download` / `callback` ports on the unit's Proxy, and that the Relay plugin is running properly;
- If the network is truly unreachable, switch to manual installation.

## Scenario 2: No installation capability on the Proxy of a non-direct unit

Symptom: installing an Agent / Proxy directly in an empty non-direct unit fails.

Cause: the first Proxy in an empty unit cannot be installed through the unit itself. It must first be established via **cross-unit installation** (initiated from another unit with installation capability) or **offline installation**.

## Scenario 3: Relay address unreachable after Proxy installation

Symptom: the Proxy installed successfully, but Agent installation / status write-back in the unit fails.

Troubleshooting: the Proxy's **first internal IP** is used as the Relay plugin's listen address and local callback address. If multiple internal IPs were filled in with the wrong order, the Relay listen or status write-back address may be unreachable. Make sure the first internal IP is a real internal address reachable by Agents / Proxies in the same unit.

## Scenario 4: SSH login failure

Troubleshooting: confirm the login port (usually SSH 22), login account (root for Linux/macOS, Administrator for Windows), and authentication method (password/key) are correct, and that the SSH/WMI channel from the installation source to the target host is reachable.

> For more server-side troubleshooting, refer to the [FAQ documents](https://github.com/TencentBlueKing/bk-nodemgr/tree/master/docs/faq) and the [troubleshooting manual](https://github.com/TencentBlueKing/bk-nodemgr/tree/master/docs/operation/troubleshooting) in the source repository.
