# What is a built-in plug-in?

Some plug-ins are built-in monitoring plug-ins that do not require user adjustment and have some special working logic.

It can only be selected directly during data collection, not in the plug-in list.

## Built-in plug-in list


- [Dynamic and static collection plug-in](../scene-process/process_pattern_monitor.md)

     The dynamic process collection plug-in is a plug-in configuration capability built into the platform and relies on bkmonitorbeat. When the collection task is configured and delivered to the target machine, it will work based on the collected task information.

     It is suitable for situations where a fixed process name matching port cannot be defined in the CMDB. For example, the port changes at any time and there is no fixed port, so it is impossible to define a port in the CMDB for monitoring.

- [Log keyword event plug-in](../alarm-configurations/keywords_event.md)

     Match the log keywords on the server where the log is located, and report the statistical values and sample data within the period. Then generate alarm events through the alarm policy to achieve the purpose of alarm.

     * **Advantages**: It can also meet the needs of log keywords when the amount of logs is large and storage resources are insufficient. The matching method is regular, which is easier to configure and understand. Meet timely alarm requirements without being affected by delays in log transmission
     * **Disadvantages**: There is only one latest sampling data. If you need more information, you need to check it through other methods.


- [SNMP Trap event plug-in](../integrations-events/snmp_trap.md)

     Obtain Trap events through SNMP