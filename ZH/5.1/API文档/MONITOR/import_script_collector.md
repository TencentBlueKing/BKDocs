
### 请求地址

/api/c/compapi/v2/monitor/import_script_collector/



### 请求方法

POST


### 功能描述

脚本采集器配置导入


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


#### 接口参数

| 字段           | 类型 | 必选 | 描述                         |
| -------------- | ---- | ---- | ---------------------------- |
| collector_conf_list | list | 是   | 脚本采集任务配置 |

#### collector_conf_list

| 字段                  | 类型   | 必选 | 描述                                                         |
| --------------------- | ------ | ---- | ------------------------------------------------------------ |
| bk_biz_id             | int    | 是   | 业务id                                                       |
| name                  | string | 是   | 数据表名，必须唯一                                           |
| description           | string | 是   | 数据表中文含义                                               |
| charset               | string | 否   | 字符集；默认值：UTF8，可选值（UTF8,GBK）                     |
| fields                | list   | 是   | 表字段信息，详情见下表                                       |
| script_type           | string | 否   | 脚本类型；默认值：file，可选值（file,cmd）                   |
| script_ext            | string | 否   | 脚本格式；默认值：shell，可选值（shell,bat,python,perl,powershell,vbs,custom） |
| params_schema         | list   | 否   | 脚本参数模型，详情见下表                                     |
| script_run_cmd        | string | 否   | 启动命令（脚本模式）                                         |
| script_content_base64 | string | 否   | 脚本内容（base64编码）                                       |
| start_cmd             | string | 否   | 启动命令（命令行模式）                                       |
| collect_interval      | int    | 否   | 采集周期(分钟)；默认值：1                                    |
| raw_data_interval     | int    | 否   | 原始数据保存周期(天)；默认值：30                             |

#### fields

| 字段         | 类型   | 必选 | 描述                                   |
| ------------ | ------ | ---- | -------------------------------------- |
| name         | string | 是   | 字段名                                 |
| description  | string | 是   | 字段描述                               |
| type         | string | 是   | 字段类型，可选值（double,long,string） |
| monitor_type | string | 是   | 指标或维度，可选值（metric,dimension） |
| unit         | string | 是   | 单位，可为空字符串：“”                 |

#### params_schema

| 字段        | 类型   | 必选 | 描述     |
| ----------- | ------ | ---- | -------- |
| name        | string | 是   | 参数名   |
| description | string | 是   | 参数描述 |

### 请求参数示例

```
{	
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "collector_conf_list": [
        {
            "fields": [
                {
                    "name": "size",
                    "description": "大小",
                    "type": "long",
                    "monitor_type": "metric",
                    "unit": ""
                }
            ],
            "charset": "UTF8",
            "name": "shell_one6",
            "description": "测试",
            "bk_biz_id": "2",
            "script_type": "file",
            "script_content_base64": "xxxxx",
            "script_ext": "shell",
            "script_run_cmd": "${bk_script_name}",
            "collect_interval": 1,
            "raw_data_interval": 30
        }

    ]
}
```

### 返回结果示例

```
{
    "message": "OK",
    "code": "0",
    "data": {
        "failed": [],
        "success": [
            {
                "script_collector_id": 8,
                "message": null,
                "name": "shell_one6"
            }
        ]
    },
    "result": true
}
```

### 返回结果参数说明

| 字段    | 类型   | 描述                                            |
| ------- | ------ | ----------------------------------------------- |
| result  | bool   | 返回结果，true为成功，false为失败               |
| code    | int    | 返回码，200表示成功，其他值表示失败             |
| message | string | 错误信息                                        |
| data    | dict   | 结果，data.success成功结果，data.failed失败结果 |

#### data.success & data.failed

| 字段    | 类型   | 描述                           |
| ------- | ------ | ------------------------------ |
| name    | string | 数据表名                       |
| id      | int    | 配置id；若无id，则表示创建失败 |
| message | string | 记录错误信息                   |