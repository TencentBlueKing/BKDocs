# Enable process monitoring

Process-related indicator data collection and monitoring are the most commonly used basic monitoring capabilities.

There are three ways to monitor processes:

1. Based on the CMDB process configuration, bkmonitorbeat will collect by default.
2. Based on the dynamic process collection plug-in (built-in), collection will be carried out according to the user's configuration requirements.
3. Customize the plug-in and collect relevant data.


## working principle


![](media/16618456580513.jpg)

### CMDB-based process configuration

BlueKing's configuration platform, CMDB, can centrally manage all configuration information. For example, it can effectively perform corresponding monitoring based on host information and process information. This is a recommended usage, so that related peripheral systems can also collaborate together.

Working principle: After CMDB is configured with process information, it will automatically send it to the server (hostid file). Monitoring is the process collection using this configuration. So you need to make sure that the CMDB is configured correctly.

```
bkmonitorbeat process monitoring logic:
1.CMDB host-service instance configuration port
2.gse server synchronizes port data from CMDB
3.gse_agent receives the data and writes it to the local machine/var/lib/gse/host/hostid
4.bkmonitorbeat monitors changes in the /var/lib/gse/host/hostid file through inotify and reads the process port information that needs to be monitored.
5. Read the monitoring status of the specified port from the Linux kernel through netlink, and report the process port data
6. In the reported data, the unmonitored port generates an alarm.
```

The process name judgment will match the contents under the three procs in order, which can be obtained directly using `readlink -f /proc/${pid}/exe`.

1. Name field in `/proc/$pid/status`
2. The file name pointed to by `/proc/$pid/exe`
3. In `/proc/$pid/cmdline`, the first element separated by whitespace characters

As long as any one of them has a hit, the process is considered to be successfully matched.

Indicator data comes from `/proc/$pid/stat`

For more specific usage, view [CMDB-based process monitoring](./process_cmdb_monitor.md)

### Based on dynamic process collection plug-in

The dynamic process collection plug-in is a plug-in configuration capability built into the platform and relies on bkmonitorbeat. When the collection task is configured and delivered to the target machine, it will work based on the collected task information.

* Benefits: Some process information that cannot be configured in CMDB, such as processes forked from the main process, can be matched.
* Disadvantage: The configuration only takes effect in monitoring and cannot be reused in other systems.

For more specific usage view [Collect process monitoring based on dynamic process plug-in] (./process_pattern_monitor.md)


### Custom plug-in for process monitoring

Custom plug-ins are the most flexible and platform-wide way. When the platform does not provide default collection capabilities, plug-ins can be used to expand.

For specific usage methods, please refer to [Plugin Production and Collection](../integrations-metric-plugins/plugins.md)