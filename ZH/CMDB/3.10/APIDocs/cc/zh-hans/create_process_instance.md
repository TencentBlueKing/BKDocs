
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/create_process_instance/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

根据服务实例 ID 和进程实例属性值创建进程实例

### 请求参数



#### 接口参数

| 字段                 |  类型      | 必选	   |  描述                 |
|----------------------|------------|--------|-----------------------|
| service_instance_id | int  | 是   | 服务实例 ID |
| processes            | array  | 是   | 进程实例中不同于模板的属性值 |

#### process_info 字段说明
| 字段|类型|必选|说明|
|---|---|---|---|
|auto_start|bool|否|是否自动拉起|
|auto_time_gap|int|否|拉起间隔|
|bk_biz_id|int|否|业务 id|
|bk_func_id|string|否|功能 ID|
|bk_func_name|string|否|进程名称|
|bk_process_id|int|否|进程 id|
|bk_process_name|string|否|进程别名|__
|bk_supplier_account|string|否|开发商账号|
|face_stop_cmd|string|否|强制停止命令|
|pid_file|string|否|PID 文件路径|
|priority|int|否|启动优先级|
|proc_num|int|否|启动数量|
|reload_cmd|string|否|进程重载命令|
|restart_cmd|string|否|重启命令|
|start_cmd|string|否|启动命令|
|stop_cmd|string|否|停止命令|
|timeout|int|否|操作超时时长|
|user|string|否|启动用户|
|work_path|string|否|工作路径|
|bind_info|object|否|绑定信息|

#### bind_info 字段说明
| 字段|类型|必选|说明|
|---|---|---|---|
|enable|bool|否|端口是否启用|
|ip|string|否|绑定的 ip|
|port|string|否|绑定的端口|
|protocol|string|否|使用的协议|
|row_id|int|否|实例化使用的模板行索引，进程内唯一|

### 请求参数示例

```json
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "service_instance_id": 48,
  "processes": [
    {
      "process_info": {
        "bk_supplier_account": "0",
        "description": "",
        "start_cmd": "",
        "restart_cmd": "",
        "pid_file": "",
        "auto_start": false,
        "timeout": 30,
        "reload_cmd": "",
        "bk_func_name": "java",
        "work_path": "/data/bkee",
        "stop_cmd": "",
        "face_stop_cmd": "",
        "bk_process_name": "job_java",
        "user": "",
        "proc_num": 1,
        "priority": 1,
        "bk_biz_id": 2,
        "bk_start_param_regex": "",
        "bk_process_id": 1,
        "bind_info": [
          {
              "enable": false,
              "ip": "127.0.0.1",
              "port": "80",
              "protocol": "1",
              "template_row_id": 1234
          }
        ]
      }
    }
  ]
}
```

### 返回结果示例

```python
{
  "result": true,
  "code": 0,
  "message": "success",
  "permission": null,
  "request_id": "e43da4ef221746868dc4c837d36f3807",
  "data": [64]
}
```

### 返回结果参数说明

#### response

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false 请求失败 |
| code | int | 错误编码。 0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data | object | 新建的进程实例 ID 列表 |