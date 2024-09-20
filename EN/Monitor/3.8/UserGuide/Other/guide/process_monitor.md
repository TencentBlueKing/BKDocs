# Process and port monitoring

The monitoring of current processes and ports depends on the configuration of CMDB. Once CMDB is configured, process-related data and events can be automatically collected.

## Preliminary steps

**working principle**:

![-w2021](media/15782901072262.jpg)

> Note: After the process information is configured in the CMDB, it will be automatically sent to the server. Monitoring is the process collection using this configuration. So you need to make sure that the CMDB is configured correctly.

The process name judgment will match the contents under the three procs in order.

1. Name field in `/proc/$pid/status`
2. The file name pointed to by `/proc/$pid/exe`
3. In `/proc/$pid/cmdline`, the first element separated by whitespace characters

As long as any one of them has a hit, the process is considered to be successfully matched.

Indicator data comes from `/proc/$pid/stat`

**Configuration steps**:

* Step 1: Configure the platform registration process & automatically issue process configuration information
* Step 2: Host monitoring to view process information
* Step 3: Set strategy
* Step 4: Set up the dashboard

Connect it and take the druid-broker process as an example.

## Step one: Configure the platform registration process

**Configuration path**: Navigation → Business → 1) Business topology → 2) Module settings → 4) Service instance settings → 5) Process settings → 6) Label settings (optional)

![-w2021](media/15795785325657.jpg)

- Process information configuration

   - Process alias (required): The externally displayed service name, user-defined, generally corresponds to the actual service name of the process, and will be used to distinguish different processes in the monitoring platform - host monitoring - host details - process service

   - Process name (required): the binary name of the program. For example, the binary name of Kafka is java, so fill in java

   - Startup parameter matching rules (optional, important): important rules to achieve accurate matching of processes, mainly applied to processes with repeated binary names such as Java or Python. The Agent-side collector will use this rule to identify the process `cmdline`. Parameter-only process. If the parameters filled in are not unique, multiple processes will be identified. If the process binary name itself is unique, it does not need to be filled in.

   - Binding IP (optional): The IP address actually monitored by the process. It does not need to be filled in. If it is filled in, it must be an address that accurately corresponds to the IP. If the IP is wrong, the collector will be unable to match the process, resulting in abnormal data reporting.

   - Port (not required): Same as "Bind IP"

   - Protocol (optional): Same as "Bind IP"

For example, the durid-broker java program:

![-w2021](media/15795784620319.jpg)

![-w2021](media/15795779439325.jpg)

For more other process configuration methods, please see [Various Process Configuration Methods](../functions/addenda/process_cases.md)

### Service Template

> Service instance: If the port, path and other information of the process are the same, it is recommended to use a service template and set the service classification. To facilitate subsequent management work. If the port paths are inconsistent, the implementation can be added automatically.

![-w2021](media/15795766656745.jpg)

**Automatic delivery**:

Modifications to the process on the configuration platform will be automatically sent to `/etc/gse/host/hostid` on the Agent through the event push function of the configuration platform. The monitored process port collector will capture file changes and perform anomaly detection. And the content is updated to the collector. The delivery time is expected to be within 2 minutes, and the page process port update information is expected to be within 5 minutes.

## Step 2: Host monitoring and process monitoring

![-w2021](media/15795765869730.jpg)

- Process: Green display when normal

- Port: Click on the process. It will be displayed in green when normal. If the port does not exist, it will be displayed in red. If it is occupied, it will be yellow. Gray means that the collector has not reported data. You need to check according to the data non-reporting process.

- Resources/Performance: Normally the chart has continuous data

- Check if the process matches exactly:
    - If it is a service whose binary is Java or Python, check whether the process port resource only reports the configured process. If the configured process is unique and there are multiple reported processes, it means that the exact match fails, and you need to confirm whether the matching parameters are unique.

![-w2021](media/15795794947955.jpg)


### No data positioning

**Configure platform event push settings**:

   - After modifying the process management information, the push will push the modified configuration to the Agent within 1 minute. Therefore, after each modification of the process management information, you can go here to confirm whether the push number has been increased.

**Configuration update confirmation**:

```bash
     # Linux Agent configuration file path
     /var/lib/gse/host/hostid
     # Windows Agent configuration file path
     /gse/data/host/hostid
     # Check whether the file contents match

     # After confirming that the hostid update is normal, switch to the following directory and check whether processbeat.conf follows the hostid to update the configuration content.
     #Linux
     /usr/local/gse/plugins/etc/processbeat.conf
     # Windows
     C:/gse/plugins/etc/processbeat.conf
```

> Note: The installation path of Agent can be modified, and the specific location can be viewed in "Node Management".

**processbeat log view**

If the previous configurations are correct, but there is still no data, you need to turn on the debug mode of processbeat to view the log information to locate it.

## Step 3: Configure alarm policy

Configure a port policy

Monitoring object selection: host-process

Add monitoring indicators: Select System Event-Process Port

Advanced options: Set trigger conditions 3/5

![Screenshot of process survival strategy](media/15833975896530.jpg)

If you monitor process indicators, the following process indicators will be collected by default [Host-Process-Indicators](../functions/addenda/process-metrics.md)

![-w2021](media/15795777521305.jpg)

Alarm group: Set up an operation and maintenance group

![-w2021](media/15795797350812.jpg)

Monitoring target selection: dynamic-druid_broker

> Information: It is recommended to use dynamic mode, so that dynamic monitoring can be carried out along with the node.

![-w2021](media/15795777925754.jpg)

## Step 4: Add a view to the dashboard

When you need to view different processes, different hosts, etc., with the indicators of concern together, you can set up a dashboard.

Specifically view the use of the dashboard [dashboard function] (../functions/report/dashboard.md)

## other

More process-related collection and viewing scenarios [How to implement multi-instance collection] (multi_instance_monitor.md)