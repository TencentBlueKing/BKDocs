# Alarm shielding

It is a common processing action after an alarm occurs. An accident may last for a long time. Continuous notifications about a known problem will obviously affect normal work and will annihilate more new alarm notifications.

Therefore, shielding is a very effective way to reduce interference, especially when you know that some operations will affect online services and generate alarms.

## Preliminary steps

**Navigation path**: Navigation → Monitoring configuration → Shield

## List of main functions

*Scope-based blocking: Blocking by target scope will not include the corresponding metrics and dimensions
     * Example
     *IP
     * node
     *Business
* Based on policy shielding: shielding based on the conditions and dimensions set by the policy
* Based on alarm event shielding: It is shielded based on the event content conditions of the alarm. The event content includes dimensions and corresponding values.
* Single blocking, periodic blocking (daily, weekly, monthly)
* Block notification: Notify before and after blocking

## Function Description

![-w2021](media/15754473248000.png)

### Range-based blocking settings

Range-based blocking means that no alarm notification will be issued as long as the monitoring within the range is blocked. If a certain IP is blocked, then the process, OS, and service instance of this IP will no longer issue alarms. If a cluster is blocked, all IPs and service instances under that cluster will no longer generate alarms.

### Based on policy blocking settings

The reason why alarms can be generated is precisely because of the policy configuration, and policy-based configuration can also locate alarm data very accurately.

> Note: The difference from policy deactivation is that blocking is only a shielded notification. Events will still be generated when the policy is in effect. However, deactivation of the policy will no longer generate events, and naturally there will be no alarm notifications.

### Based on alarm event shielding settings

Alarm events are a specific dimension condition in the policy, so if you want to be able to block events, you can operate directly in the event details.

### Shielding period setting

The default is a commonly used single time range, but if the characteristics of the business are cyclical, for example, offline calculations will be performed in the early morning of every day, occupying a large amount of resources without alarming, or there will be data statistics every Monday. There is a reconciliation every month, which causes the monitored objects to periodically generate alarms. Then you can use the periodic settings of daily, weekly, and monthly.

### Block notification settings

The blocking notification setting plays a certain prompting role.

* Notification object: It can be a role or a single person
* Notification method: the same as the notification method of the alarm group
*Notification time: Notify before shielding the alarm and after the shielding fails. Periodic notifications are given before and after each periodic notification.

## Other related blocking

* **Alarm Confirmation**: Based on the current event shielding, it is shielded according to the current alarm event. Once the event is restored, it will become invalid. Please view the event center-event details-alarm confirmation.
* **Quick Blocking**:
     * Policy list page-quick shielding, quick shielding based on policies
     * Event details - quick shielding, quick shielding based on event conditions
* **Host operating status**:
     * The host operation status field of CMDB, once enabled, will determine whether to block based on the host operation field.
     * Host operation status switch: Navigation → System Management → Global Configuration → Host operation status switch