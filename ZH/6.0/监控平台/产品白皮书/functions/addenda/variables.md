# 变量列表

监控平台提供了一些变量的使用场景，如采集的参数，告警的通知模版，与 CMDB 打通获取相关的一些变量数据，可以更加方便的进行配置和管理。

##  变量格式说明

Jinja2 是一个现代的，设计者友好的，仿照 Django 模板的 Python 模板语言。它速度快，被广泛使用，并且提供了可选的沙箱模板执行环境保证安全：

```html
<title>{% block title %}{% endblock %}</title>
<ul>
{% for user in users %}
  <li><a href="{{ user.url }}">{{ user.username }}</a></li>
{% endfor %}
</ul>
```

## 模板变量

### Alarm/告警变量

| 变量                   | 名称             | 示例                |
| ---------------------- | ---------------- | -------------------|
| alarm.target_string    | 告警目标         | 10.0.1.10,10.0.1.11 |
| alarm.dimension_string | 告警维度(除目标) | 磁盘=C，主机名=xxx   |
| alarm.collect_count    | 汇总事件数量     | 10                  |
| alarm.notice_from      | 消息来源         | 监控平台            |
| alarm.company          | 企业标识         | 蓝鲸                |
| alarm.data_source_name | 数据来源名称     | 数据平台            |
| alarm.data_source      | 数据来源         | BKMONITOR           |
| alarm.detail_url       | 详情链接         |                     |
| alarm.current_value    | 当前值           | 1.1                 |
| alarm.target_type      | 目标类型         | IP/INSTANCE/TOPO    |
| alarm.target_type_name | 目标类型名称     | IP/实例/节点        |



### Strategy/策略变量

| 变量                          | 名称       | 示例              |
| ----------------------------- | ---------- | -----------------|
| strategy.strategy_id          | 策略 ID     | 1                 |
| strategy.strategy_name        | 策略名称   | CPU 总使用率       |
| strategy.scenario             | 场景       | os                |
| strategy.source_type          | 数据来源   | BKMONITOR         |
| strategy.bk_biz_id            | 业务 ID     | 2                 |
| strategy.item.result_table_id | 结果表名称 | system.cpu_detail |
| strategy.item.name            | 指标名称   | 空闲率            |
| strategy.item.metric_field    | 指标字段   | idle              |
| strategy.item.unit            | 单位       | %                 |
| strategy.item.agg_interval    | 周期       | 60                |
| strategy.item.agg_method      | 聚合方法   | AVG               |


#### Content / 通知内容变量

| 变量                  | 名称         | 示例 |
| --------------------- | ------------| ---- |
| content.level         | 告警级别     |      |
| content.time          | 告警时间     |      |
| content.duration      | 告警持续时间 |      |
| content.target_type   | 告警目标类型 |      |
| content.data_source   | 告警数据来源 |      |
| content.content       | 告警内容     |      |
| content.biz           | 告警业务     |      |
| content.target        | 告警目标     |      |
| content.dimension     | 告警维度     |      |
| content.detail        | 告警详情     |      |
| content.current_value | 告警当前值   |      |


### CMDB 变量

CMDB 变量在采集的参数中也是可以使用的。

#### Business / 业务变量

| 变量                                     | 名称           | 示例              |
| ---------------------------------------- | --------------| -----------------|
| target.business.bk_biz_id                | 业务 ID         | 2                |
| target.business.bk_biz_name              | 业务名称       | 蓝鲸              |
| target.business.bk_biz_developer_string | 开发人员字符串 | admin,user1,user2 |
| target.business.bk_biz_maintainer_string | 运维人员字符串 | admin,user1       |
| target.business.bk_biz_tester_string     | 测试人员字符串 | admin,user1       |
| target.business.bk_biz_productor_string  | 产品人员字符串 | admin,user1       |
| target.business.operator_string          | 操作人员字符串 | admin,user1       |


#### Host / 主机变量

| 变量                               | 名称                   | 示例        |
| ---------------------------------- | ----------------------| ----------- |
| target.host.bk_host_id             | 主机 ID                | 1           |
| target.host.bk_biz_id              | 业务 ID                | 2           |
| target.host.bk_cloud_id            | 云区域 ID              | 0           |
| target.host.bk_cloud_name          | 云区域名称            | 默认区域    |
| target.host.bk_host_innerip        | 内网 IP                | 10.0.0.1    |
| target.host.bk_host_outerip        | 外网 IP                | 10.0.1.11   |
| target.host.bk_host_name           | 主机名                |             |
| target.host.bk_os_name             | 操作系统名称          | Linux       |
| target.host.bk_os_type             | 操作系统类型(枚举数值) | 1           |
| target.host.operator_string        | 负责人                | admin,user1 |
| target.host.bk_bak_operator_string | 备份负责人            | admin,user1 |


#### Process / 进程变量

| 变量                                                | 名称         | 示例         |
| --------------------------------------------------- | ------------| ------------ |
| target.process.["process_name"].bk_process_id       | 进程 ID       | 1            |
| target.process.["process_name"].bk_process_name     | 进程名称     | 进程 1        |
| target.process.["process_name"].bk_func_name        | 进程功能名称 | java         |
| target.process.["process_name"].bind_ip             | 绑定 IP       | 10.0.1.10    |
| target.process.["process_name"].port                | 绑定端口     | 1,2,3-5,7-10 |
| target.process.["process_name"].process_template_id | 进程模板 ID   | 1            |
| target.process.["process_name"].service_instance_id | 服务实例 ID   | 1            |
| target.process.["process_name"].bk_host_id          | 主机 ID       | 1            |


#### ServiceInstance / 服务实例变量

| 变量                                        | 名称       | 示例          |
| ------------------------------------------- | ----------| ------------- |
| target.service_instance.service_instance_id | 服务实例 ID | !             |
| target.service_instance.name                | 服务实例名 | xxx_10.0.1.11 |
| target.service_instance.bk_host_id          | 主机 ID     | 1             |
| target.service_instance.bk_module_id        | 模块 ID     | 1             |
| target.service_instance.service_category_id | 服务分类 id | 1             |
