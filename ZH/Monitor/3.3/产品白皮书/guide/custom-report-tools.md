# 自定义上报工具

自定义上报可以通过命令行工具进行上报， 实现发送自定义事件/自定义时序等自定义数据。

支持通过 gse agent 和 bkmonitorporxy(http 接口)两种方式实现自定义上报， 上报之前会在本地进行 jsonschema 校验。

## 第一步： 申请数据 ID 

**导航位置**：导航  →  监控配置  →  自定义上报

选择是指标还是事件。

## 第二步： 命令行使用方法

```bash
# 输出帮助信息(实际输出更多，发送自定义数据相关参数带有report关键字)
:!./bkmonitorbeat -h
Usage of ./bkmonitorbeat:
  -report
    Report event to time series to bkmonitorproxy
  -report.agent.address string
    agent ipc address, default /var/run/ipc.state.report (default "/var/run/ipc.state.report")
  -report.bk_data_id int
    bk_data_id, required
  -report.event.content string
    event content
  -report.event.name string
    event name
  -report.event.target string
    event target
  -report.event.timestamp int
    event timestamp
  -report.http.server string
    http server address, required if report type is http
  -report.http.token string
    token, , required if report type is http
  -report.message.body string
    message content that will be send, json format
  -report.message.kind string
    message kind, event or timeseries
  -report.type http
    report type http or `agent`
```

### 使用样例

基本使用部分提供通用的使用方法，适用于自定义事件和自定义时序数据上报，由于事件内容涉及到较多特殊字符处理，后面单独介绍针对自定义事件的上报方法。
如下代码演示用于发送自定义事件的数据（其中 json 内容来自监控插件配置右侧的帮助信息）。

```bash
# 通过gse agent发送自定义事件， 无返回
./bkmonitorbeat -report -report.bk_data_id 1500512 \
-report.type agent \
-report.message.kind event \
-report.message.body '{
    "data_id":1500512,
    "access_token":"991146b7e97b409f8952d59355b5f5c7",
    "data":[{
        "event_name":"input_your_event_name",
        "target":"127.0.0.1",
        "event":{
            "content":"user xxx login failed"
        },
        "dimension":{
            "amodule":"db",
            "aset":"guangdong"
        },
        "metrics":{
            "field1":1.1
        },
        "timestamp":1591067660370
        }
    ]}'

 # 通过http方式发送自定义事件，成功返回code200，result true
./bkmonitorbeat -report -report.bk_data_id 1500512 -report.type http -report.http.server 10.0.1.36:10205 -report.message.kind event -report.message.body '{
    "data_id":1500512,
    "access_token":"991146b7e97b409f8952d59355b5f5c7",
    "data":[{
        "event_name":"input_your_event_name",
        "target":"127.0.0.1",
        "event":{
            "content":"user xxx login failed"
        },
        "dimension":{
            "amodule":"db",
            "aset":"guangdong"
        },
        "metrics":{
            "field1":1.1
        },
        "timestamp":1591067660370
        }
    ]}'
{"code":"200","message":"success","request_id":"4a6b1b1e-0af0-4834-87c5-6443662df7d3","result":"true"}
```

### 通过 gse agent 上报自定义事件数据

本示例采用单独指定各个上报字段的方式，用于解决拼装 json 麻烦的问题。

```bash
# 通过指定各个字段的方式发送自定义事件数据，采用默认时间
./bkmonitorbeat -report \
-report.type agent \
-report.message.kind event \
-report.bk_data_id 1500512 \
-report.event.target 127.0.0.1 \
-report.event.name xxxxxxxxx \
-report.event.target yyyyyyyyy \
-report.event.content zzzzzz
```

```bash
# 通过指定各个字段的方式发送自定义事件数据，指定上报时间
./bkmonitorbeat -report \
-report.type agent \
-report.message.kind event \
-report.bk_data_id 1500512 \
-report.event.target 127.0.0.1 \
-report.event.name xxxxxxxxx \
-report.event.target yyyyyyyyy \
-report.event.content zzzzzz \
-report.event.timestamp 1595944620000
```

### 通过 bkmonitorproxy 上报自定义事件数据

```bash
./bkmonitorbeat -report \
-report.type http \
-report.http.server 10.0.1.10:10205 \
-report.http.token 991146b7e97b409f8952d59355b5f5c7 \
-report.message.kind event \
-report.bk_data_id 1500512 \
-report.event.target 127.0.0.1 \
-report.event.name xxxxxxxxx \
-report.event.target yyyyyyyyy \
-report.event.content zzzzzz
```

### 效果查看

**导航位置**：导航  →  监控配置  →  自定义上报  →  检查视图

