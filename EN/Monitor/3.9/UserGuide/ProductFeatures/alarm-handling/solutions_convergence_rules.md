# Description of defense rule list


This article introduces several current convergence modes of self-healing, and uses some existing general convergence rules to illustrate its usage. I hope that the convergence rules can meet your various needs, and after configuring them, you will forget that they exist. Currently, the built-in dimensions of convergence include: alarm level, trigger signal, and package configuration. The built-in dimensions of notifications also include: notification person, notification method

## Abnormal defense approval

Each processing action that satisfies the defense rules will generate an approval document, allowing the person in charge to approve it and decide whether it needs to be executed. If it is agreed, it will continue to be executed. If it is rejected or it times out for 30 minutes and is not approved, it will be directly converged and not processed.

* Example: Trigger N items within 5 minutes for abnormal defense approval and convergence

* Explanation: If the same policy triggers M (M>N) packages within 5 minutes, the package will be executed normally for the first N times, and an approval document will be generated in the process service for the N+1 ~ M times. A total of M - N documents are generated here, and each document corresponds to a package execution.

## Skip during execution

After the rule is triggered, if there are other alarms that meet the rules and are being self-healed, the current alarm will be skipped and directly set to ignore.

Can be used to avoid duplication of processing.

* Example: Trigger N items within 5 minutes, skip convergence during execution

* Explanation: If the same policy triggers M (M > N) packages within 5 minutes, the first N times will be executed normally. The N+1 ~ M times will query the current policy and host to see if there is an executing package. If it exists, Then skip execution directly, otherwise execute normally. When using this convergence method, the actual number of executions depends on the real-time status of the task and will range from N to M times.

## Waiting during execution

After the rule is triggered, if there are other alarms that meet the rules and are being self-healed, wait until the other alarms are self-healed before continuing to process the current alarm.

Users can perform mutually exclusive alarm processing, or have sequence-dependent alarm processing.

* Example: Trigger N items within 5 minutes, wait for convergence during execution

* Explanation: If the same policy triggers M (M > N) packages within 5 minutes, the first N times will be executed normally. The N+1 ~ M times will query the current policy and host to see if there is an executing package. If it exists, Then wait for the last execution to complete, otherwise execute normally. The result is that a total of M packages are actually executed, of which the first N times are executed in parallel and the N+1 ~ M times are executed serially.

## Skip after success

After the rule is triggered, if there are other alarms that meet the rules and are successfully self-healed, the current alarm will be skipped. If it fails, the process of self-healing will continue.

Can be used to implement failure retries.

* Example: Trigger N items within 5 minutes, skip convergence after success
* Explanation: If the same policy triggers M (M > N) packages within 5 minutes, the first N times will be executed normally, and the N+1 ~ M times will query the last execution result. If it is being executed, wait; If it fails, execute the package, if it succeeds, skip it. The result is that at most N executions are successful within 5 minutes.

## Ignore after exceeding

After the rule is triggered, alarms exceeding the number will be converged and not processed.

After the rule is triggered, if there are other alarms that meet the rules and are successfully self-healed, the current alarm will be skipped. If it fails, the process of self-healing will continue.

Can be used to implement failure retries.

* Example: Trigger N items within 5 minutes, ignore convergence after exceeding
* Explanation: If the policy triggers M (M > N) packages within 5 minutes, the first N times will be executed normally, and the N+1 ~ M times will be skipped. That is, it can actually be executed up to N times within 5 minutes.

## Summary after exceeding (notification package built-in)

When encountering the same policy, monitoring dimension, alarm level, trigger signal, notification method, and notification personnel, if there is more than 1 alarm within 2 minutes, notifications will no longer be sent, and summary notifications will be sent after 1 minute. Policy summary event, the current summary notification will be suppressed.

## Same business summary (built-in notification package)

First-level convergence: that is, summary convergence after exceeding

By default, 3 or more first-level convergences are achieved within 2 minutes (same business, same recipients, same notification method, same alarm level, same trigger signal, convergence time window and quantity can be customized in the global configuration) , the same business will be aggregated and converged (secondary convergence)

* Example:

     * Strategy A: Notifications are triggered 3 times within 2 minutes. The first time will be notified normally and a summary window will be opened. The second and third times will be skipped.
     * Strategy B: 2 notifications are triggered within 2 minutes. The first time will be notified normally and a summary window will be opened. The second time will be skipped.
     * Strategy C: Notifications are triggered 3 times within 2 minutes. The first time will be notified normally and a summary window will be opened. The second and third times will be skipped.
There will be two situations at this time

* All policies have the alarm storm switch turned on
     * When the business summary is triggered, a business summary notification will be sent after 1 minute. The alarm content also includes A(2~3), B(2), C(2~3)
* Any of the policies turns off the alarm storm switch
     * Three summary notifications will be sent after 1 minute. One alarm content contains A(2~3), one alarm content contains B(2), and one alarm content contains C(2~3).