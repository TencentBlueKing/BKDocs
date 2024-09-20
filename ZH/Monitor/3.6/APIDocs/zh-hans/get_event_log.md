
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/monitor_v3/get_event_log/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询事件流转记录

### 请求参数



#### 接口参数

| 字段 | 类型   | 必选 | 描述   |
| ---- | ------ | ---- | ------ |
| id   | string | 是   | 告警 ID |

#### 示例数据

```json
{
  "bk_app_code": "xxx",
  "bk_app_secret": "xxxxx",
  "bk_token": "xxxx",
  "id": 164239028644167
}
```

### 响应参数

| 字段    | 类型   | 描述         |
| ------- | ------ | ------------ |
| result  | bool   | 请求是否成功 |
| code    | int    | 返回的状态码 |
| message | string | 描述信息     |
| data    | dict   | 数据         |

#### data 字段说明

| 字段        | 类型   | 描述     |
| ----------- | ------ | -------- |
| status      | string | 状态     |
| event_id    | string | 事件 ID   |
| message     | string | 记录消息 |
| operate     | string | 记录类型 |
| extend_info | dict   | 其他数据 |
| create_time | string | 创建时间 |

#### operate - 记录类型

* CREATE - 告警产生
* CONVERGE - 告警收敛
* RECOVER - 告警恢复
* CLOSE - 告警关闭
* DELAY_RECOVER - 延迟恢复
* ABORT_RECOVER - 中断恢复
* SYSTEM_RECOVER - 告警恢复
* SYSTEM_CLOSE - 告警关闭
* ACK - 告警确认
* SEVERITY_UP - 告警级别调整
* ACTION - 处理动作

#### status - 状态

* SUCCESS - 成功

#### extend_info

不同类型的记录的数据各不相同

##### ANOMALY_NOTICE - 告警通知

* action - 通知配置(参考"查询事件"接口文档中的 action_list 说明)

```json
{
    "action": {}
}
```

##### CONVERGE - 告警收敛

* process_time - 收敛数据点的处理时间段
* anomaly_count - 收敛异常点数量
* data_time - 收敛数据点的数据时间段
* anomaly_record - 异常点记录(参考"查询事件"接口文档中的 origin_alarm 说明)

```json
{
    "process_time": {
        "max": 1583914154,
        "min": 1583911227
    },
    "anomaly_record": {},
    "data_time": {
        "max": 1583914020,
        "min": 1583911080
    },
    "anomaly_count": 50
}
```

#### 示例数据

```json
{
    "result": true,
    "code": 200,
    "message": "ok",
    "data": [
        {
            "status": "SUCCESS",
            "event_id": "164239028644167",
            "message": "",
            "operate": "CREATE",
            "extend_info": "",
            "create_time": "2020-01-01 00:00:00"
        }
    ]
}
```

|
|