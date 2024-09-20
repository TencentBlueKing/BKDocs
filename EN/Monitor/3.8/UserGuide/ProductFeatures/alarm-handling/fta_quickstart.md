# Quickly use fault self-healing capabilities

## Understand the three steps

1. Define the alarm source. By default, the alarm of BlueKing monitoring itself is used.
2. Define the processing package and the specific logic that should be executed for alarm processing
3. Define the alarm policy and associate the processing package in the alarm policy to achieve automatic execution.

## Step one: Alarm source

By default, using BlueKing Monitoring does not require access to alarm sources. BlueKing Monitoring itself is an alarm source.

Access more monitoring alarm sources [see details](../integrations-alerts/custom_alerts_source.md)

## Step 2: Process the package

The processing package defines the alarm processing actions. When an alarm is triggered, in addition to sending alarm messages, there can also be actions related to alarm processing, such as alarm callbacks, alarm processing and other functions. This function links the alarm and operation and maintenance systems to realize automatic processing and automatic recovery of faults.

### Process package list

Process the package as shown below.
![](media/16616646263138.jpg)




1. Processing package description: The processing package can be triggered through the alarm policy, and the processing package can be connected with surrounding systems to complete complex functions.
2. Package type: Supports HTTP callback, operating platform, standard operation and maintenance, and process services by default
3. Association policy: Configure the policy for this package
4. Number of triggers (in the past 7 days): only the number in the processing record list is counted, and the number of convergence and shielding is not counted. And you can click directly to jump to the processing record.
5. Default package: The default exception notification, alarm recovery notification, no data notification, etc. are all built-in policies and are not allowed to be modified, so you need to add a mark "default"; and disable deletion. Tips explain that the default policy does not allow deletion. . There are 4 default notification packages built in, which cannot be deleted by users.
     *Default alarm exception notification
     *Default alarm recovery notification
     * No data alarm notification by default
     * Alarm shutdown notification by default


### Add new processing package

![](media/16616646753137.jpg)


Basic Information

* Package name: easy to identify when used in strategies
* Whether to enable: enabled by default
* Description: Describe the purpose of this package

Package information

* Package type: Supports HTTP callback, operating platform, standard operation and maintenance, and process services by default
* When selecting different package types, different information needs to be filled in
* Failure judgment: Set the timeout time for execution. If the execution is not completed within the specified time, it will be treated as execution failure.

Package description

* Instructions on how to use different packages

variable list

* [Reference package built-in variables](./solutions_parameters_all.md)


## Step 3: Alarm strategy

Use packages in alert policies

In the alarm policy, on the alarm processing action, select the processing package we have configured

![](media/16616647228224.jpg)


defense rules

The defense rules are divided into two parts:

* Judgment conditions: When encountering the same host, policy, module, host, dimension, target, rack, switch, computer room, process name, port, and alarm characteristics. (Remove business, because there is a business dimension by default)
* Judgment window: when triggered more than M times within N minutes

Perform defensive actions:
    
* skip after success
* Skip during execution
* Waiting during execution
* Abnormal defense approval
* Summarized after exceeding
* For detailed instructions, see [Defense Rule List](./solutions_convergence_rules.md)

Example:

For example, if you restart a server, you should not normally need to restart hundreds of servers at the same time, because the execution operations are data-driven. Once the data judgment is abnormal, a defense mechanism is needed to ensure that there will not be too many executions.

## Alarm events

The specific execution status can be viewed in the alarm event. For details, please view [Alarm Processing Record](../alarm-analysis/alert_recording.md)

When the alarm policy does not configure the relevant processing package, but after receiving the alarm, you want to quickly execute or obtain relevant information (such as obtaining the process information of the TOP10 or manually executing the trigger process, etc.), you can manually call the processing package to meet the needs.


![](media/16616650336934.jpg)