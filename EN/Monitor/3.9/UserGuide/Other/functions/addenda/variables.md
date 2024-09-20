# variable list

The monitoring platform provides usage scenarios for some variables, such as collected parameters, alarm notification templates, and can be connected with CMDB to obtain some related variable data, making configuration and management more convenient.

## Variable format description

Jinja2 is a modern, designer-friendly Python templating language modeled after Django templates. It's fast, widely used, and provides an optional sandbox template execution environment to ensure security:

```html
<title>{% block title %}{% endblock %}</title>
<ul>
{% for user in users %}
   <li><a href="{{ user.url }}">{{ user.username }}</a></li>
{% endfor %}
</ul>
```

## Template variables

### Alarm/alarm variable

| variable | name | example |
| ----------------------- | ------------- | --------------------|
| alarm.target_string | Alarm target | 10.0.0.1,10.0.0.11 |
| alarm.dimension_string | Alarm dimension (except target) | Disk=C, hostname=xxx |
| alarm.collect_count | Number of aggregated events | 10 |
| alarm.notice_from | Source | Monitoring Platform |
| alarm.company | Corporate Identity | BlueKing |
| alarm.data_source_name | Data source name | Data platform |
| alarm.data_source | data source | BKMONITOR |
| alarm.detail_url | Detail link | |
| alarm.current_value | current value | 1.1 |
| alarm.target_type | target type | IP/INSTANCE/TOPO |
| alarm.target_type_name | Target type name | IP/instance/node |



### Strategy/strategy variable

| variable | name | example |
| -------------------------- | ---------- | -----------------|
| strategy.strategy_id | Strategy ID | 1 |
| strategy.strategy_name | Strategy name | Total CPU usage |
| strategy.scenario | scenario | os |
| strategy.source_type | data source | BKMONITOR |
| strategy.bk_biz_id | Business ID | 2 |
| strategy.item.result_table_id | result table name | system.cpu_detail |
| strategy.item.name | Indicator name | Idle rate |
| strategy.item.metric_field | Metric field | idle |
| strategy.item.unit | unit | % |
| strategy.item.agg_interval | period | 60 |
| strategy.item.agg_method | Aggregation method | AVG |


#### Content / notification content variable

| variable | name | example |
| --------------------- | ------------| ---- |
| content.level | Alarm level | |
| content.time | Alarm time | |
| content.duration | Alarm duration | |
| content.target_type | Alarm target type | |
| content.data_source | Alarm data source | |
| content.content | Alarm content | |
| content.biz | Alarm business | |
| content.target | Alarm target | |
| content.dimension | Alarm dimension | |
| content.detail | Alarm details | |
| content.current_value | Alarm current value | |

### CMDB variables

CMDB variables are also available in collected parameters.

#### Business / business variables

| variable | name | example |
| ---------------------------------------- | --------------| ------------------|
| target.business.bk_biz_id | Business ID | 2 |
| target.business.bk_biz_name | Business name | BlueKing |
| target.business.bk_biz_developer _string | Developer string | admin,user1,user2 |
| target.business.bk_biz_maintainer_string | Operation and maintenance personnel string | admin,user1 |
| target.business.bk_biz_tester_string | Tester string | admin,user1 |
| target.business.bk_biz_productor_string | Product person string | admin,user1 |
| target.business.operator_string | Operator string | admin,user1 |


#### Host / Host variable

| variable | name | example |
| ---------------------------------- | -----------------------| ----------|
| target.host.bk_host_id | Host ID | 1 |
| target.host.bk_biz_id | Business ID | 2 |
| target.host.bk_cloud_id | Cloud zone ID | 0 |
| target.host.bk_cloud_name | Cloud zone name | Default zone |
| target.host.bk_host_innerip | Intranet IP | 10.0.0.1 |
| target.host.bk_host_outerip | External IP | 10.0.0.11 |
| target.host.bk_host_name | host name | |
| target.host.bk_os_name | Operating system name | Linux |
| target.host.bk_os_type | Operating system type (enumeration value) | 1 |
| target.host.operator_string | Person in charge | admin,user1 |
| target.host.bk_bak_operator_string | Backup person in charge | admin,user1 |


#### Process / process variables

| variable | name | example |
| ---------------------------------------------------- | ------------| ------------ |
| target.process.["process_name"].bk_process_id | Process ID | 1 |
| target.process.["process_name"].bk_process_name | process name | process 1 |
| target.process.["process_name"].bk_func_name | Process function name | java |
| target.process.["process_name"].bind_ip | Bind IP | 10.0.0.1 |
| target.process.["process_name"].port | Binding port | 1,2,3-5,7-10 |
| target.process.["process_name"].process_template_id | Process template ID | 1 |
| target.process.["process_name"].service_instance_id | Service instance ID | 1 |
| target.process.["process_name"].bk_host_id | Host ID | 1 |


#### ServiceInstance / Service instance variable

| variable | name | example |
|------------------------------------------------ | ----------|-------------|
| target.service_instance.service_instance_id | Service instance ID | ! |
| target.service_instance.name | Service instance name | xxx_10.0.0.11 |
| target.service_instance.bk_host_id | Host ID | 1 |
| target.service_instance.bk_module_id | module ID | 1 |
| target.service_instance.service_category_id | Service category id | 1 |