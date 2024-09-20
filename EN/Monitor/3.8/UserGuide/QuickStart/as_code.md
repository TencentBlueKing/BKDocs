# plan description

In order to facilitate users to version manage and quickly reuse configurations, the BlueKing monitoring platform has launched the Monitor As Code capability.

Simply put, all monitoring configurations on BKMonitor can be generated through Yaml and provide a set of Git management capabilities for submitting changes to monitoring configurations.

## Advantage

1. Yaml configuration is simple
2. Code generation and batch management possible
3. Utilize version control in the code repository
4. More friendly to developers
5. Can be combined with business coding and version
6. Convenient reuse and migration

## Disadvantages

1. Need to be familiar with Yaml syntax
2. Complex functional processes cannot be guided through As Code.

This can be solved directly using the UI.

# Start configuration

## Configuration directory

```
├── action
│ ├── job.yaml
│ ├── snippets
│ │ └── base.yaml
│ └── webhook.yaml
├── grafana
│ └── host.json
├── notice
│ ├── duty.yaml
│ ├── ops.yaml
│ └── snippets
│ └── base.yaml
└── rule
     ├── all.yaml
     ├── cpu_simple.yaml
     ├── cpu_simple_with_snippet.yaml
     └── snippets
         └── base.yaml
```

* action - self-healing package configuration
* action/snippets - self-healing package snippets
* notice - Alarm group configuration
* notice/snippets - Alert group snippets
* rule - Alarm policy configuration
* rule/snippets - Alarm policy snippets
* grafana - Grafana Dashboard configuration

## Configuration snippet (snippet)

The same configuration fragment may exist in many configurations. To facilitate configuration reuse, we provide the configuration snippet capability.

The prepared snippet configuration can be referenced through the snippet field in the configuration file.

For example, when configuring multiple notification groups, the configuration of the notification channel may be exactly the same. At this time, we can extract it as a configuration fragment, and we can reference it in other fragments.


### notice/snippets/base_notice_type.yaml

```yaml
alert:
  00:00--23:59:
    remind:
      type: [weixin, mail]
    warning:
      type: [weixin, mail]
    fatal:
      type: [weixin, mail]
action:
  00:00--23:59:
    execute:
      type: [weixin, mail, wxwork-bot]
      chatids: [xxxxxxxxxxx, yyyyyyyyyyy]
    execute_failed:
      type: [weixin, mail]
    execute_success:
      type: [weixin, mail]
```

### notice/ops.yaml

```yaml
name: Ops
description: ""
# reference sinnpet
snippet: base_notice_type.yaml

users: [user1, group#bk_operator]

alert:
  00:00--23:59:
    remind:
      type: [weixin]
```

### rendered notice/ops.yaml

```yaml
name: Ops
description: ""

users: [user1, group#bk_operator]

alert:
  00:00--23:59:
    remind:
      type: [weixin]
    warning:
      type: [weixin, mail]
    fatal:
      type: [weixin, mail]
action:
  00:00--23:59:
    execute:
      type: [weixin, mail, wxwork-bot]
      chatids: [xxxxxxxxxxx, yyyyyyyyyyy]
    execute_failed:
      type: [weixin, mail]
    execute_success:
      type: [weixin, mail]
```

## Alarm Rule

Here is a simple example，it show a minimum alarm rule.

```yaml
name: CPU sage is too high
query:
  data_source: bk_monitor
  data_type: time_series
  query_configs:
  - metric: system.cpu_summary.usage
    method: avg
    interval: 60
    group_by:
    - bk_target_ip
    - bk_target_cloud_id

detect:
  algorithm:
    fatal:
    - type: Threshold
      config: ">95"

  trigger: 5/10/6

notice:
  user_groups:
  - Ops
```

- query defines the source and type of alarm data, as well as how to query the data.  
- detect defines how to determine when abnormal situations occur.  
- notice defines how to notify when an alarm occurs.  
- action defines the configuration of self-healing packages.

## Base Config

```yaml
name: Test Rule
labels:
- label1
- label2
enabled: true
active_time: "00:00--23:59"
active_calendar: []
```

|  config item | required | default | enum | description |
| --- | --- | --- | --- | --- |
| name | true |  |  | Rule name |
| labels | false | [] |  | The labels of Rule |
| enabled | false | true | true/false | Rule is enabled |
| active_time | false | 00:00--23:59 | | Rule active time, support multiple config, split by comma. Multiple active time range can't overlap. |
| active_calendar | false | [] | | Active calendar ids |

## Query Section

```yaml
query:
  data_source: bk_monitor
  data_type: time_series
  expression: a + b
  query_configs:
  - metric: system.disk.free
    query_string: "*"
    method: avg
    interval: 60
    group_by: []
    functions:
    - delta(2m)
    - abs
    where: bk_target_ip="1" or bk_target_cloud_id!="2" or bk_target_ip=~"1" or bk_target_ip!~"111" or device_name="4"
    alias: a
  - metric: system.disk.free
    method: avg
    interval: 60
    group_by: []
    functions:
    - delta(2m)
    - abs
    where: bk_target_ip="1" or bk_target_cloud_id!="2" or bk_target_ip=~"1" or bk_target_ip!~"111" or device_name="4"
    alias: b
```

### Where

"where" define the filter of data.

### Format

Base item: `{dimension|}{method}"{value}"`

e.g. `bk_target_ip="1"`

The value can split by Comma.

e.g. `bk_target_ip="127.0.0.1,127.0.0.2"`

Multiple item can connect with and/or, the priority of and calculation is higher than that of or.

e.g. `bk_target_ip="127.0.0.1" and bk_target_cloud_id="0"`

### Method

| method | description |
| --- | --- |
| = | equal |
| != | not equal | 
| ~= | regex |
| ~! | not regex |
| =- | include substring |
| ~- | not include substring |

### data_source and data_type

| data_source       | data_type   | description  |
|--------------|--------------|----------------------------|
|  prometheus  | time_series   | use promql to query data in bk_monitor |
| bk_monitor   | time_series  | time seris data collect by bk_monitor |
| bk_monitor   | event        | system event               |
| bk_monitor   | log          |     log keyword collect    |
| bk_monitor   | alert        |                            |
| bk_data      | time_series  |     data from bk_data       |
| bk_fta       | event        |                            |
| bk_fta       | alert        |                            |
| bk_log_search | time_series | metric from bk_log_search  |
| bk_log_search | log         | log count from bk_log_search |
| custom       | time_series  |     custom metric     |
| custom       | event        |      custom event          |

### prometheus, time_series (Recommended)

> not support multiple query_configs calculate expression, but you can calculate by promql Directly.

It can cover all data of (bk_monitor/custom, time_series), support promql.

```yaml
metric: system:disk:usage{bk_target_ip="127.0.0.1"}
interval: 5m
```

### bk_monitor/custom, time_series

> support multiple query_configs calculate expression

## Metric

metric format is **result_table_id.metric_name**, e.g. system.disk.usage.
if the **result_table_id** is empty, just write **metric_name**.

### Functions

todo

### Config

```yaml
expression: a # use alias name of query_configs, like: a + b
query_configs:
- alias: a
  metric: system.disk.usage
  method: avg # avg/sum/min/max/count
  interval: 60
  group_by: [bk_target_ip]
  where: bk_target_ip="127.0.0.1,127.0.0.2"
  functions:
  - rate(1m)
  - abs
```

## bk_log_search, time_series

> not support multiple query_configs calculate expression

### Metric

metric format is  **"index_set_id.metric_name"**，e.g. 1000.online

### config

```yaml
metric: 1000.online
method: avg
interval: 60
group_by: [bk_target_ip]
where: bk_target_ip="127.0.0.1,127.0.0.2"
```

## bk_monitor, event

this is a special data_source, it do not require any detection algorithm because they are inherently abnormal. You should keep algoritm config empty.
```yaml
algorithm:
  fatal: {}
```

### Metric

metric format is **"system.event.{event_name}"**，如system.event.agent-gse

### Event

| event name | description |
| --- | --- |
|  agent-gse | gse Agent beat lost |
|  disk-readonly-gse | disk readonly |
|  disk-full-gse | disk full |
|  corefile-gse | corefile |
|  ping-gse | ping unreachable |
|  os_restart | host restart |
|  gse_custom_event | custom event report |
|  proc_port | process port alarm |
| gse_process_event | gse process event |

### Config

```yaml
metric: system.event.agent-gse
where: bk_target_ip="127.0.0.1,127.0.0.2"
```

## Detect Section

Here is the complete detect config.

```yaml
detect:
  algorithm:
    operator: and

    fatal:
    - type: Threshold
      config: ">1 or <2"
    warning:
    - type: SimpleRingRatio
      config:
        floor: 10
        ceil: 23
    remind:
    - type: AdvancedRingRatio
      config:
        floor: 10
        ceil: 15
        ceil_interval: 7
        floor_interval: 5

  trigger: 2/10/6

  nodata:
    continuous: 10
    dimensions: []
    level: fatal
```

### Description

|  config item | required | default | enum | description |
| --- | --- | --- | --- | --- |
| algorithm.operator | false | and | and/or | The relationship between detection algorithms at the same level. If it is "and", all detection algorithms must meet the conditions to trigger the alert. Otherwise, any detection algorithm that meets the conditions can trigger the alert. |
| algorithm.{level} | true | | fatal/warning/remind | At least one level needs to be configured, and multiple detection algorithms can be configured under each level. |
| algorithm.{level}.type | true | | | The type of detection algorithm. |
| algorithm.{level}.config | true | | | The configuration of the detection algorithm. The configuration structure of different detection algorithms is different. |
| trigger | true | | | The alert triggering condition. "x/y/z" means that if the detection algorithm is triggered x times within y cycles, an alert will be generated. After z consecutive cycles no longer meet the triggering condition, the alert will recover. |
| nodata | false | | | The type of detection algorithm for no data. |
| nodata.continuous | true | | | The number of cycles for no data detection. |
| nodata.dimensions | false | [] | | The dimensions for no data detection. |
| nodata.level | true | | | The alert level for no data. |


## Algorithm

BkMonitor supports multiple detection algorithms. The following are the parameters and meanings of the basic algorithms.

### Threshold

Threshold algorithm, supports `>/>=/</<=/=` operators and `and/or`
Does not support parentheses
The priority of and calculation is higher than that of or.

```yaml
type: Threshold
config: ">=1 or <1 and <0 or =-1"
```
### SimpleYearRound

The current value has increased by ceil% or decreased by floor% compared to the same time last week.
"ceil" or "floor" needs to be configured at least one.

```yaml
type: SimpleYearRound
config:
  ceil: 10
  floor: 10

type: SimpleYearRound
config:
  ceil: 10
```

### SimpleRingRatio

The current value has increased by ceil% compared to the previous moment, or decreased by floor% compared to the previous moment.

```yaml
type: SimpleRingRatio
config:
  ceil: 10
  floor: 10
```

### AdvancedYearRound

The average absolute value at the same time point ceil_interval days ago has increased by ceil%, or decreased by floor% at the same time point floor_interval days ago.
```yaml
type: AdvancedYearRound
config:
  ceil: 10
  ceil_interval: 1
  floor: 10
  floor_interval: 1
```

### AdvancedRingRatio

The current value has increased by ceil% compared to the previous moment, or decreased by floor% compared to the previous moment.

```yaml
type: AdvancedRingRatio
config:
  ceil: 10
  ceil_interval: 1
  floor: 10
  floor_interval: 1
```

### YearRoundAmplitude

```yaml
type: YearRoundAmplitude
config:
  ratio: 10
  shock: 1
  days: 10
  method: >=
```
method: `>/>=/</<=/=`

### RingRatioAmplitude

current value and previous value both `>=` threshold, and (current value - previous value) >= previous value × ratio + shock

```yaml
type: RingRatioAmplitude
config:
  ratio: 10
  shock: 1
  threshold: 10
```

### YearRoundRange

current value {method } absolute value of simultaneous moments within the past days × ratio + shock

```yaml
type: YearRoundRange
config:
  ratio: 10
  shock: 1
  days: 10
  method: >=
```
method: `>/>=/</<=/=`

## Notice Section

```yaml
notice:
  signal:
    - recovered
    - abnormal
  exclude_notice_ways:
  closed: [voice]
    recovered: [rtx, mail]  
  user_groups:
  - ops.yaml
  - Ops
  biz_converge: true
  interval: 120
  interval_mode: standard
  noise_reduce: # 降噪配置 
    enabled: false 
	dimensions: ["bk_target_ip", "bk_target_cloud_id"]
	abnormal_ratio: 10 # percent(1-100) 
  assign_mode: ["only_notice","by_rule"]
  template:
    abnormal:
      title: "aaa"
      content: "aaa"
    recovered:
      title: "aaa"
      content: "aaa"
    closed:
      title: "aaa"
      content: "aaa"
```

|  config item | required | default | enum | description |
| --- | --- | --- | --- | --- |
| signal | false | abnormal | abnormal/recovered/closed /execute/execute_success /execute_failed | Stages that require sending notice. |
| exclude_notice_ways | false |  | closed/recovered | disable some notice type in some stages |
| user_groups | true | | | notice target, use user group name or user group config yaml filename |
| biz_converge | false | true | false/true | alarm storm defense |
| interval | false | 120 | | notice interval (min) |
| interval_mode | false | standard | standard/increasing | increasing mode will auto increase interval if the alarm keeping abnormal |
| noise_reduce | false |  | |  noise reduction |
| noise_reduce.enabled | false |false/true | |  Is noise reduce enabled?  |
| noise_reduce.dimensions | true if enabled  | | |  Dimensions for noise reduction |
| noise_reduce.abnormal_ratio | true if enabled  | | |  Anomaly ratio of dimensions, notification will be triggered if this condition is met |
| assign_mode | false |[only_notice, by_rule]|only_notice/by_rule |how to dispatch alert to users |
| template | false | | | notice template |

## User Group

### Group from CMDB

* operator
* bk_bak_operator
* bk_biz_maintainer
* bk_biz_productor
* bk_biz_tester
* bk_biz_developer

### Simple User Group

```yaml
name: Name
description: ""
channels: [user, bkchat，wxwork-bot]
alert:
  00:00--23:59: 
    fatal:
      notice_ways:
      - name: bkchat
        receivers:
        - wxwork-bot|239
        - mail|238
        - QQ|237
        - WEWORK|236
        - DING_WEBHOOK|249
	   - name: weixin
	   - name: wxwork-bot
	       receivers:
        - xxxxxxxxxxx
		- yyyyyyyyyyy
    remind:
      notice_ways:
      - name: bkchat
        receivers:
        - wxwork-bot|239
        - mail|238
        - QQ|237
        - WEWORK|236
        - DING_WEBHOOK|249
    warning:
      notice_ways:
      - name: bkchat
        receivers:
        - wxwork-bot|239
        - mail|238
        - QQ|237
        - WEWORK|236
        - DING_WEBHOOK|249


action:
  00:00--23:59:
    execute:
      notice_ways:
      - name: bkchat
        receivers:
        - wxwork-bot|239
        - mail|238
        - QQ|237
        - WEWORK|236
        - DING_WEBHOOK|249
	   - name: weixin
	   - name: wxwork-bot
	       receivers:
        - xxxxxxxxxxx
		- yyyyyyyyyyy
    execute_failed:
      notice_ways:
      - name: bkchat
        receivers:
        - wxwork-bot|239
        - mail|238
        - QQ|237
        - WEWORK|236
        - DING_WEBHOOK|249
	   - name: weixin
	   - name: wxwork-bot
	       receivers:
        - xxxxxxxxxxx
		- yyyyyyyyyyy
    execute_success:
      notice_ways:
      - name: bkchat
        receivers:
        - wxwork-bot|239
        - mail|238
        - QQ|237
        - WEWORK|236
        - DING_WEBHOOK|249
	   - name: weixin
	   - name: wxwork-bot
	       receivers:
        - xxxxxxxxxxx
		- yyyyyyyyyyy
users: [user1, group#bk_biz_maintainer]
```

### Rotation User Group

```yaml
duties:
# not handover
- user_groups: [[group#bk_operator, xxx]] # only one group
  type: weekly # type weekly/daily/monthly
  work:
    days: [1, 2] # weekly: 1-7，monthly: 1-31
    time_range: 00:00--23:59
  effective_time: 2022-05-24 17:35:00 # start time

# handover
- user_groups: [[group#bk_operator, xxx], [yyy, zzz]] # handover in multiple group
  type: monthly
  handover:
    date: 3 # handover day，weekly: 1-7，monthly: 1-31
    time: 00:00 # handover time
  work:
    days: [1, 2]
    time_range: 00:00--23:59
  effective_time: 2022-05-24 17:35:00
```
## Dashboard Grafana

Grafana is configured in json format, completely using Grafana's original configuration, and snippet cannot be used.

We do not recommend manually editing the grafana dashboard configuration. We recommend exporting the configuration after configuring it on Grafana.

If the uid or title of the dashboard is the same as the existing dashboard configuration, the existing dashboard will be overwritten.
![](media/16906172384379.jpg)

![](media/16906172448152.jpg)


## Import configuration

We provide the Blue Shield pipeline plug-in to synchronize the configuration to the BlueKing monitoring platform. By default, you need to use a public build machine. If you use a private build machine, you need to apply for bkapps igate access permissions in devcloud.

> Configuration synchronization is full synchronization rather than incremental synchronization. Please ensure that the configuration provided each time is complete. Missing configurations will be deleted simultaneously.

Grafana dashboard configuration can only provide incremental functions, and configuration grouping cannot take effect. After deleting the configuration file, the imported Grafana dashboard cannot be deleted simultaneously.

![](media/16906172932844.jpg)


Only the business ID, Token, and configuration directory path must be configured.

* The business ID is the target business to which the configuration is to be imported.

*Token is obtained using https://bkm.xxx.com/rest/v2/commons/token_manager/get_api_token/?bk_biz_id=xxxxx. It is unique under the business. Please do not disclose it. Only those with policy and dashboard management permissions can obtain it. .

* The configuration directory path needs to be configured as the root path of the configuration directory mentioned at the beginning of the document.

* Configuration grouping allows multiple independent AsCode configurations to be configured under the same business without overwriting each other. The default is default. Different groups are managed independently, but configurations with the same name cannot appear. It is recommended that different groups agree on configuration naming rules to avoid duplicate names.

* Just confirm that the monitoring platform address is consistent with the monitoring address used. No modification is required if there are no special requirements.

Overwriting configurations with the same name In order to facilitate exporting and then importing existing policies, an option is provided to allow configurations with the same name to be overwritten across groups. Please use it with caution.

## Export existing configuration

In order to facilitate the use of AsCode function to manage existing configurations, we provide the configuration export function.

https://bkmonitor.xxx.com/rest/v2/as_code/export_config/?bk_biz_id=xxxxx

Just fill in the corresponding business ID and open it in the browser.

The re-import of the exported configuration may fail due to the same name. In this case, you need to enable the option to overwrite the configuration with the same name.

We also provide a configuration export plug-in for everyone to use

![](media/16906173667286.jpg)