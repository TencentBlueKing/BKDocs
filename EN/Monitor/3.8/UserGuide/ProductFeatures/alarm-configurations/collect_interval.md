# Second level monitoring

## What is second-level monitoring?

**Second-level monitoring** means that monitoring data collects target data in a second-level cycle, and displays the retrieved data and performs alarm detection on a second-level cycle.

## Usage scenarios for second-level monitoring

- Core business data
-Business stress testing scenario
- Performance monitoring scenarios
- Critical link monitoring
- Core device data

## Second-level monitoring function

| Classification | Implementation | Reporting cycle | Collection cycle |
| :--------- | :---------------------------------- | :------------ | :------------------------------------------------------------------- |
| Operating system | Collect indicators through the collector | 1 minute | Collect 4 times in 1 minute, a cycle of 15 seconds, take the maximum value and report **max (a total of 4 times collected in 1 minute at intervals of 15 seconds)** |
| Customized reporting | Reported to HTTP data interface through HTTP data format | Can be less than 1 minute | Determined by reporting frequency |
| Plug-in collection | Obtain user-defined plug-in data through the collector | Minimum 10 seconds | 10 seconds |

    Can the collector period be 1 second? Here we have comprehensively considered the usage scenarios and temporarily set the operating system indicators to be reported once every minute, while the platform itself can support second-level collection capabilities.

    Currently, the minimum limit of plug-in collection period is 10 seconds. Because in some cases, the collection plug-in script itself takes several seconds to execute. If it is set to 1 second, data will not be collected. Therefore, the platform sets the minimum value period to 10 seconds. , which can meet the usage scenarios of most users. However, it does not rule out that in some scenarios, users may need to use a collection cycle of 1 second, 5 seconds, or milliseconds.

## How to use second-level monitoring

Below we give practical examples to illustrate how to use second-level monitoring, from data collection, to data display, to data alarms, let's experience it together.

### Collection cycle

In the collection, we choose **Collection period is 10 seconds**, and **Collection timeout** can be configured to be less than 10 seconds. We need to ensure that the script can be executed within 10 seconds.

![](media/16618630621807.jpg)

### Configure alarm policy

In the alarm policy, select the period as 10 seconds, and the policy period needs to be greater than or equal to the collection period

![](./media/15754467635626.png)