# Host monitoring

How to simply and quickly ensure the stable operation of business basic hosts through BlueKing monitoring.

## Preliminary steps

Dependent components: configuration platform, management and control platform, node management

Users need to import the controlled host into the configuration platform and install the Agent (Quick Start for Hyperlink Configuration Platform), or directly install the Agent under the corresponding business through node management and import it into the host (Quick Start for Hyperlink Node Management).

# Check the basic performance of the host through the view

BlueKing Monitoring pulls host information from the interface of the configuration platform. After the agent is installed on the controlled machine, the collector will discover and report regularly (1 time/minute) the basic performance information of the host. After processing by the BlueKing data link, the host information will be displayed on the host machine. You can view the basic performance data of the corresponding host on the monitoring page.

- View: including host monitoring list page, host monitoring details page, and process resource monitoring page

   - Host monitoring list page

     It supports sorting the CPU usage, disk IO usage, and CPU 5-minute average load of the current business indicators to understand the hosts that use the most resources under the current business.

     ![-w2021](../media/15367262171256.jpg)

     ![-w2021](../media/15367265482031.jpg)

     - Query conditions support associated configuration platform

     ![-w2021](../media/15367266647004.jpg)

     - Display in groups according to standard attributes of configuration receipts

     ![-w2021](../media/15367437077809.jpg)

   - Host monitoring details page

     Host monitoring includes a total of 32 indicators in 5 categories: CPU, memory, disk, system, and network, allowing users to accurately query the basic performance of the host in real time.

     ![-w2021](../media/15367418510768.jpg)

   - Process port and resource monitoring

     After the process port monitoring configuration is completed, it will be displayed on the host monitoring list page - Process Service according to the host it belongs to. Click the process to view [Process Monitoring](./process_monitor.md)

     ![-w2021](../media/15367426268275.jpg)


# Host monitoring policy configuration

- **1. System default policy**

For the convenience of users, after the new business is imported into the host, the system will automatically create common monitoring strategies for 11 indicators such as Corefile generation, total CPU usage, system restart, etc. Users can create new strategies based on actual scenarios to generate alarms.

> For details of the default policy, please see [Appendix](host_monitor_end.md)

- **2. User-defined strategy**

   2.1 You can choose to add strategies in batches after selecting the host in host monitoring, or go to Monitoring Configuration - Host Monitoring and select the indicator type to edit the strategy.

   - Batch increase strategy.

   ![-w2021](../media/host_monitor_config.png)

   - Find the indicators that need to be configured in the monitoring configuration.

   ![-w2021](../media/15367439293084.jpg)


- **3. Select monitoring objects**

   - Press the host IP and select a single or multiple hosts through the IP selector, which is generally used during testing.

   ![-w2021](../media/host_monitor_object.png)

   - According to the business topology, host information is automatically pulled according to the configuration platform cluster and module you choose. Host movement/removal will automatically adapt to the monitoring strategy.

   ![-w2021](../media/monitor004.png)

- **4. Detection rules**

   - Hierarchical alarm: When multiple alarm levels are checked, different algorithms and triggering conditions can be configured respectively.

     - Example: Configure the total CPU usage alarm policy. In the same policy, you can configure that the current value >50% triggers a reminder level alarm, the current value >70% triggers an early warning level alarm, and the current value >90% triggers a fatal level alarm. High-level alarms will override low-level alarms.

   - Detection algorithm: Provides a variety of algorithm rules according to user needs.

     - Indicators such as CPU usage can be detected using static thresholds, and indicators such as the number of people online on the server can be detected using year-on-year/month-on-month algorithms.

   ![-w2021](../media/monitor005.png)

   > Recommendation: Select 5 periods by default to satisfy the N-time detection algorithm
   > (1) For jitter indicators such as total CPU usage, N can be selected as 3; for non-jitter indicators such as disk usage, N can be selected as 1.
   > (2) Prepare for alarm convergence recovery detection. For example, if the detection algorithm is satisfied 2 times within 5 minutes, the trigger condition for resuming detection is that the detection algorithm is satisfied less than 2 times in the previous 5 cycles.

- **5. Trigger conditions**

   The detection period of timing indicators (CPU, memory, etc.) defaults to the collection period, and the event alarm is fixed to 1 minute.

   ![-w2021](../media/monitor006.png)

   ![-w2021](../media/monitor007.png)

- **6. Alarm convergence**

   - In order to avoid alarm storms caused by continuous alarm triggering for a period of time, if the alarm status is not restored after the alarm is generated, the alarm will not be issued again within "N" hours. For example, "N" = 24, after the alarm notification is issued, 24 This alarm will no longer be generated within hours. If the business needs the alarm to continue to be generated (trigger an alarm and send a notification), please set "N" to 0.

   - Alarm recovery detection: Contrary to the alarm detection conditions, for example, the trigger condition is `"Within 5 cycles, the detection algorithm is met 3 times"`, then the trigger condition of the alarm recovery detection is "When the trigger condition is met, it will be checked whether it is met" The algorithm detected less than 3 times in the first 5 cycles`".

   ![-w2021](../media/monitor008.png)

> The default alarm time is 24 hours.
> After alarm convergence, the event center will display only the alarms issued by default, and converged alarms will no longer be displayed.

   - No data alarm: If this option is checked, the indicator will continue to generate data. If the data is suddenly not reported, a no data alarm will be generated. It is recommended to use CPU, memory, disk, etc. that will report themselves for a long time and do not report abnormal data.

> The no-data detection cycle is the data reporting cycle. If the user does not configure it, it generally defaults to 1 time/minute.

   ![-w2021](../media/monitor009.png)

   > If the reported data itself is discontinuous, it is not recommended to turn it on.

   - Alarm convergence triggers and examples:
     - The trigger conditions and alarm convergence settings are as follows:

       ![-w2021](../media/monitor010.png)

     - The trigger condition is met in the 15th cycle (the detection algorithm is met twice in the 11th-15th cycle: threshold >= 100), and the recovery detection condition is met in the first 5 cycles (the detection algorithm is met less than 2 times in the 10th-14th cycle ), so an alarm is generated in the 15th cycle.

     - The trigger conditions are met in the 21st cycle (the detection algorithm is met twice in the 17-21 cycles), but the recovery detection conditions are not met in the first 5 cycles (the detection algorithm is not met less than 2 times in the 16-20 cycles, the alarm is not recovery), so no alarm is generated in the 21st cycle.

     - If the trigger condition is met from the beginning of the 16th cycle to the next 24 hours, no alarm will be generated during the period. An alarm will be generated until the trigger condition is met again 24 hours later. Here, it is considered that the trigger condition is always met but the user is only notified once. Processing may be missed.

       ![-w2021](../media/15391535322210.jpg)

- **7. Notification method**

   - Graded alarms:

     - Check the hierarchical alarm to assign different notification methods and notification roles to different levels of alarms.

       ![-w2021](../media/host_monitor_notice.png)

     - If unchecked, the notification method and notification role will be uniformly configured for alarms under this policy.

       ![-w2021](../media/host_monitor_notice2.png)

   - Alarm method: You can choose whether to send a notification when an alarm occurs/recovers.

   - Notification method: The role is automatically synchronized from the configuration platform, and the role contact information will be obtained from the user management of the PaaS platform.

   - Notification method: Notification method is divided into: email/business WeChat & WeChat public account/SMS/phone. Please refer to the PaaS document for the configuration method.

> The primary/backup person in charge represents the person role corresponding to the primary/backup person in charge field in the host configuration in the configuration platform.

- **8. Alarm shielding**

# Alarm query

Historical alarm data can be viewed in different forms in the main menu of BlueKing Monitoring - Event Center.

   - 1. List mode: Display historical alarm data in list form, providing multiple dimensions so that users can accurately filter and display corresponding alarms

     ![-w2021](../media/monitor_check_alarm.png)

   - 2. Calendar mode: Display historical alarm data in calendar form, making it convenient for users to display historical alarm data through the time dimension.

     ![-w2021](../media/monitor_check_alarm2.png)