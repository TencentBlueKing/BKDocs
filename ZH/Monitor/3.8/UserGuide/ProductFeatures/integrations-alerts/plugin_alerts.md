# 监控源插件制作

## 1. 插件包目录结构

插件包为 `tar.gz` 格式的压缩包，解压后至少包含以下文件

```
.
├── plugin.yaml      # 插件元信息
├── alert.yaml       # 告警名称匹配规则
├── logo.png         # 插件logo
├── description.md   # 插件描述文档
└── tutorial.md      # 插件配置向导文档
```

## 2. 文件说明

### plugin.yaml

插件元信息，格式如下

```yaml
# HTTP Push 类型插件示例

# 插件ID - 小写+下划线组成，全局唯一
plugin_id: monitor_custom_event
# 插件显示名称
plugin_display_name: 蓝鲸监控自定义事件
# 插件类型，可选 http_pull, http_push
plugin_type: http_push
# 插件描述
summary: 兼容监控自定义事件上报格式
# 插件作者
author: 蓝鲸智云

# 插件标签
tags:
- Restful

# 配置参数模板, 安装插件的时候需要填写的内容
config_params:
- field: method
  name: 请求方法
  value: ""
  is_required: true
  is_sensitive: false
  default_value: GET
  desc: 数据类型
- field: url
  value: ""
  name: 请求url
  is_required: true
  is_sensitive: false
  default_value: "http://127.0.0.1:8000"

# 接入配置，必填
ingest_config:
  # 源数据格式，可选 json, yaml, xml, text, 默认为json
  source_format: json
  # 可选，单条数据是否包含了多个事件，默认为 false
  multiple_events: true
  # 可选，事件数据所在的路径(JMESPath)，当 multiple_events 为 true 时可用。默认为空，即整个data属于是事件数据
  events_path: data

# 字段清洗规则，field - 字段名，expr - 转换表达式
# 如果某些字段不需要生成，则直接去掉对应配置即可
normalization_config:
- field: alert_name  # 告警名称 - 告警名称通过匹配规则生成，是事件去重的重要依据
  expr: alert_name
- field: event_id    # 事件ID - 事件的唯一标识符，用于识别重复事件
  expr: event_id
- field: description  # 描述 - 事件的详细描述及主体内容
  expr: description
- field: metric  # 指标项 - 事件对应的指标项
  expr: metric
- field: category  # 分类 - 事件所属的数据分层
  expr: category
- field: assignee  # 受理人 - 事件受理人，可作为动作的执行者
  expr: assignee
- field: status  # 状态 - 事件状态，用于控制告警状态流转。不提供则默认为 "ABNORMAL"
  expr: status
- field: target_type  # 目标类型 - 产生事件的目标类型
  expr: target_type
- field: target   # 目标 - 产生事件的目标
  expr: target
- field: severity  # 级别 - 事件的严重程度，1:致命; 2:预警; 3:提醒
  expr: severity
- field: bk_biz_id  # 业务ID - 事件所属的业务ID，不提供则根据 target 自动解析
  expr: bk_biz_id
- field: tags   # 标签 - 事件的额外属性，K-V 键值对，不支持嵌套结构
  expr: tags
- field: time   # 事件时间 - 事件产生的时间，不提供则默认使用采集时间
  expr: timestamp
  # 转换选项
  option:
    # 对于时间字段，可以配置时间解析规则 
    time_format: epoch_millis
- field: anomaly_time  # 异常时间 - 事件实际发生异常的时间，不提供则默认使用事件时间
  expr: anomaly_time
```

```yaml
# HTTP Pull 类型插件示例

# 插件ID - 小写+下划线组成，全局唯一
plugin_id: fta_rest_pull
# 插件显示名称
plugin_display_name: Rest拉取
# 插件类型
plugin_type: http_pull
# 插件描述
summary: 拉取符合故障自愈标准格式的事件
# 插件作者
author: 蓝鲸智云

# 插件标签
tags:
- Restful

# 接入配置，必填
ingest_config:
  # 源数据格式，可选 json, yaml, xml, text, 默认为json
  source_format: json
  # 单条数据是否包含了多个事件，默认为 false
  multiple_events: true
  # 事件数据所在的路径(JMESPath)，当 multiple_events 为 true 时可用。默认为空，即整个data属于是事件数据
  events_path: data
  # 拉取请求方法，可选 GET, POST, PUT, 默认为 GET
  method: GET
  # 拉取请求URL
  url: http://10.10.10.10:18888/
  
  # 请求头配置，可选
  headers:
    # header 名称
  - key: content—type
    # header 取值
    value: application/json
    # header 描述
    desc: xxxx
    # 是否启用
    is_enabled: true
  
  # 鉴权配置，可选
  authorize:
    # 鉴权类型，可选 none, basic_auth, bearer_token
    auth_type: basic_auth
    # 鉴权信息
    auth_config:
      # 用户名，当鉴权类型为 basic_auth 需配置
      username: robot,email
      # 密码，当鉴权类型为 basic_auth 需配置
      password: wwerwrxfsdfsfsdfdsfsdf12312sd
      # token，当鉴权类型为 bearer_token 需配置
      token: xxxx, 当为token校验的时候

  # 请求体，可选
  body:
    # 编码类型，可选 default, raw, form_data, x_www_form_urlencoded，默认为 default
    data_type: raw
    # 请求体内容，可引用参数 {{begin_time}}, {{end_time}}, {{page}}, {{page_size}}}, {{limit}}, {{offset}}
    content: '{"bk_app_code": "bk_bkmonitorv3", "bk_app_secret": "BSUznLVIEzD9", "bk_username": "admin", "bk_biz_ids": [2], "time_range": "{{begin_time}} -- {{end_time}}", "page": {{page}}, "page_size": {{page_size}}}'
    # 内容类型，当 data_type 为 raw 时可用，可选 text, json, html, xml 默认为 text
    content_type: json

    # 参数列表，可选，当编码方式为 urlencoded 时需要提供
    params:
    - key: content—type
      # 参数值，可引用参数 {{begin_time}}, {{end_time}}, {{page}}, {{page_size}}}, {{limit}}, {{offset}}
      value: application/json
      desc: xxxx
      is_enabled: true

  # URL 查询字符串配置，可选
  query_params:
  - key: bk_biz_id
    # 参数值，可引用参数 {{begin_time}}, {{end_time}}, {{page}}, {{page_size}}}, {{limit}}, {{offset}}
    value: '2'
    desc: url请求参数
    is_enabled: true

  # 拉取请求间隔，单位s，默认60
  interval: 60
  # 拉取请求重叠时间，单位s，默认0
  overlap: 10
  # 拉取请求超时时间，单位s，默认60
  timeout: 60
  # 拉取请求时间格式，可选项如下，默认为 timestamp 
  # timestamp - 秒级时间戳，例: 1634182237
  # epoch_millis - 毫秒级时间戳，例: 1634182350512
  # datetime - 日期字符串，例: "2006-01-02 15:04:05"
  # rfc3339 - 带时区的日期字符串，例: "2006-01-02T15:04:05Z07:00"
  time_format: datetime

  # 分页配置，可选
  pagination:
    # 分页类型，可选 page_number, limit_offset
    type: page_number
    # 分页选项
    option:
      # 全局最大拉取数量
      max_size: 10
      # 单次拉取数量
      page_size: 5
      # total字段所在的路径(JMESPath)
      total_path: "meta.total"
	  
# 字段清洗规则，field - 字段名，expr - 转换表达式
# 如果某些字段不需要生成，则直接去掉对应配置即可
normalization_config:
- field: alert_name  # 告警名称 - 告警名称通过匹配规则生成，是事件去重的重要依据
  expr: alert_name
- field: event_id    # 事件ID - 事件的唯一标识符，用于识别重复事件
  expr: event_id
- field: description  # 描述 - 事件的详细描述及主体内容
  expr: description
- field: metric  # 指标项 - 事件对应的指标项
  expr: metric
- field: category  # 分类 - 事件所属的数据分层
  expr: category
- field: assignee  # 受理人 - 事件受理人，可作为动作的执行者
  expr: assignee
- field: status  # 状态 - 事件状态，用于控制告警状态流转。不提供则默认为 "ABNORMAL"
  expr: status
- field: target_type  # 目标类型 - 产生事件的目标类型
  expr: target_type
- field: target   # 目标 - 产生事件的目标
  expr: target
- field: severity  # 级别 - 事件的严重程度，1:致命; 2:预警; 3:提醒
  expr: severity
- field: bk_biz_id  # 业务ID - 事件所属的业务ID，不提供则根据 target 自动解析
  expr: bk_biz_id
- field: tags   # 标签 - 事件的额外属性，K-V 键值对，不支持嵌套结构
  expr: tags
- field: time   # 事件时间 - 事件产生的时间，不提供则默认使用采集时间
  expr: timestamp
  # 转换选项
  option:
    # 对于时间字段，可以配置时间解析规则 
    time_format: epoch_millis
- field: anomaly_time  # 异常时间 - 事件实际发生异常的时间，不提供则默认使用事件时间
  expr: anomaly_time
```

### tutorial.md

插件配置向导文档，用于说明需要怎样配置才能接入到该插件，markdown格式。如下：

```md
1. 上报格式

    {
        "data": [{
            "event_name": "input_your_event_name",
            "event": {
                "content": "user xxx login failed"
            },
            "target": "127.0.0.1",
            "dimension": {
                "module": "db",
                "location": "guangdong"
            },
            "timestamp": 1618901413120
        }]
    }

2. Python SDK 下载

    点击<a download="sdk.py" href="./asset/sdk.py">下载脚本</a>
```

#### 静态文件引用
如果内容中包含对图片、文本文件或其他静态资源的引用，可以通过**相对路径**引用，插件包打包时以相同的路径规则带进去即可，如上述例子，目录结构如下

```
├── .
│   ├── alert.yaml
│   ├── asset  # 引用的静态文件目录
│   │   └── sdk.py
│   ├── description.md
│   ├── logo.png
│   ├── plugin.yaml
│   └── tutorial.md
```

#### 静态文件的文本替换
有时候引入的静态文件是一段代码，而这段代码里面可能需要根据实际的环境去替换对应的参数（如token, url等信息）。可以通过定义占位符的方式实现。当前支持的占位符有 插件token `{{ plugin.token }}` 和 推送url `{{ plugin.ingest_config.push_url }}`

如以下代码

```python
# -*- coding: utf-8 -*-

import requests


token = "{{ plugin.token }}"
url = "{{ plugin.ingest_config.push_url }}"


def report(payload):
    """
    上报数据
    """
    response = requests.post(
        url=url,
        json=payload,
        headers={
            "X-Bk-Fta-Token": token,
        }
    )
    return response
```

通过 `./asset/sdk.py` 链接下载时，py文件将会替换为以下内容

```python
# -*- coding: utf-8 -*-

import requests


token = "123456abcdef"
url = "http://test.com"


def report(payload):
    """
    上报数据
    """
    response = requests.post(
        url=url,
        json=payload,
        headers={
            "X-Bk-Fta-Token": token,
        }
    )
    return response
```

### description.md

插件描述文档，用于介绍插件的功能，markdown格式。如下：

```markdown
## 1. 插件说明

推送符合故障自愈标准格式的事件

## 2. 插件作者

![](./asset/蓝鲸智云.png)

```

> 注意：tutorial.md 所提及的静态文件引用规则，依然适用于该文档

### alert.yaml

```yaml
- name: CPU Usage   # 匹配的告警名称
  rules:   # 匹配规则，可选。不提供为全部匹配
  - key: origin_config.name   # 字段名
    value:  # 取值，字符串的列表
    - "^CPU"
    method: reg   # 匹配方法，可选 eq, neq, reg
  - key: strategy_name
    value:
    - "CPU"
    - "cpu"
    method: eq
    condition: or   # 条件连接符，可选 and, or，默认为 and。只有一个rule的情况无需提供 
- name: Default
```

### logo.png
插件 LOGO 图片，png 格式


## 3. 插件包导入方式

将上述文件夹进行压缩，压缩格式要求为 `tar.gz`

### (1) API导入

```
POST /fta/plugin/event/import/
```

请求格式：form-data

请求参数

| 参数名 | 含义 | 类型 | 是否必填 |
| ------ | ------ | ------ | ------ |
| `bk_biz_id` | 业务ID，0代表全业务 | int | 是 |
| `file_data` | 插件包 | File Object | 是 |
| `force_update` | 当插件ID存在时，是否强制覆盖更新，默认为 `false` | bool | 否 |



### (2) 命令导入

```
# Step 1. 进入 SaaS APPO 机器
ssh $BK_APPO_IP

# Step 2. 将插件包拷贝到母机的bkmonitor代码根目录
cp test_plugin.tar.gz /data/bkee/paas_agent/apps/projects/bk_monitorv3/code/bk_monitorv3

# Step 3. 调用容器的bash执行django command，导入插件包
docker exec -it `docker ps | grep "bk_monitorv3" | awk '{print($1)}'` bash -c "cd /data/app/code/ ; /cache/.bk/env/bin/python manage.py import_event_plugin test_plugin.tar.gz"
```


