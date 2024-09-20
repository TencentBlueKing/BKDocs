# BlueKing Application Auto Scaling

> The Developer Center provides an auto-scaling feature for applications, helping SaaS developers manage application resources and the number of service replicas more effectively.

## Feature Introduction

Based on the GPA component of BCS, the Developer Center offers the capability for BlueKing applications to auto-scale, currently mainly supporting scaling based on resource metrics.

After enabling the auto-scaling feature in the Developer Center, your managed BlueKing applications will have the following capabilities:

- Automatically increase the number of replicas during peak loads to reduce the load and response time of each replica.
- Automatically decrease the number of replicas during off-peak loads to save resources and costs.

In future feature planning, we will also support scenarios such as scaling based on traffic volume, application hibernation, and scheduled scaling.

## Scaling Policies

### Resource-based Scaling

#### Single Metric Scenario

Resource-based scaling primarily relies on the `average utilization` of resources to calculate the desired number of replicas. The simplified calculation formula is as follows: `desiredReplicas = Ceil((currentUtilization / targetUtilization) * currentReplicas)`

For example, suppose there are currently two replicas of the web process: Pod1 & Pod2, with the resource metric set to `CPU Utilization = 85%`, a maximum of 5 replicas, and a minimum of 2 replicas.

When Pod1 and Pod2 have CPU utilization rates of 100% and 80%, respectively, the average CPU utilization rate for the web process is 90%. After calculation, the expected number of replicas is `Ceil(90 / 85 * 2) = 3`; since the current number of replicas and the expected number of replicas do not exceed the maximum, it will scale up to 3 replicas.

When Pod1 and Pod2 have CPU utilization rates of 30% and 50%, respectively, the average CPU utilization rate for the web process is 40%. After calculation, the expected number of replicas is `Ceil(40 / 85 * 2) = 1`; however, since the expected number of replicas is lower than the minimum, it can only scale down to 2 replicas, and since the current number of replicas is the same as the minimum, no scaling action will be triggered.

| CPU Utilization | Average CPU Utilization | Expected Replicas | Not Exceeding Max/Min Replicas | Action |
| -------------- | ---------------------- | ---------------- | ----------------------------- | ------ |
| 100% / 80%     | 90%                    | 3                | ✓                             | Scale Up |
| 30% / 50%      | 40%                    | 1                | ✗                             | None   |

According to the formula, when the resource metric is set to `CPU Utilization = 85%`, if the average CPU utilization exceeds 85% and does not reach the maximum number of replicas, scaling up will be triggered; if the average CPU utilization is below `(currentReplicas - 1)/currentReplicas * 85` and does not reach the minimum number of replicas, scaling down will be triggered; this value is 42.5% when there are currently two replicas, 56.7% when there are three replicas, and so on for other cases.

Of course, if a replica is not in a ready state, it will not be included in the calculation of the average resource utilization.

#### Multiple Metrics Scenario

If we use multiple resource metrics, such as `CPU Utilization = 85% && Memory Utilization = 80%`, then the scaling decision rules are as follows:

Scaling Up Conditions:

- CPU utilization exceeds the scaling up threshold **or** memory utilization exceeds the scaling up threshold.
- The current number of replicas has not reached or exceeded the maximum number of replicas.

Scaling Down Conditions:

- CPU utilization is below the scaling down threshold **and** memory utilization is below the scaling down threshold.
- The current number of replicas has not reached or fallen below the minimum number of replicas.

The same logic applies to scenarios with more metrics.

### Scaling Effectiveness Time

The auto-scaling capability follows a `fast scale up, slow scale down` strategy; that is, when the conditions for scaling up are met, the change in the number of replicas can be quickly completed; when the conditions for scaling down are met, continuous monitoring will occur until the scaling down conditions are met throughout the entire stability window period before scaling down will be performed.

## Usage Guide

Applications can configure auto-scaling on the product page:

- Cloud Native Applications: 'Deploy' -> 'Expand Instance Details' -> 'Scaling' -> 'Auto Adjustment'
- Regular Applications: 'APP Engine' -> 'Processes' -> 'Scaling' -> 'Auto Adjustment'

For applications deployed based on source code, auto-scaling can also be defined in the [APP description file](./app_desc.md).

Note: Currently, the Developer Center limits resource scaling metrics to a fixed `CPU Utilization = 85%`, with custom metrics to be made available for selection in the future.