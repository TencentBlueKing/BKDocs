
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/update_process_instance/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

批量更新进程信息

### 请求参数



#### 接口参数

| 字段                 |  类型      | 必选	   |  描述                 |
|----------------------|------------|--------|-----------------------|
| processes            | array  | 是   | 进程信息 |
| bk_biz_id            | int  | 是   | 业务 id |

#### processes 字段说明
| 字段|类型|说明|
|---|---|---|
|process_template_id|int|进程模版 id|
|auto_start|bool|是否自动拉起|
|auto_time_gap|int|拉起间隔|
|bk_biz_id|int|业务 id|
|bk_func_id|string|功能 ID|
|bk_func_name|string|进程名称|
|bk_process_id|int|进程 id|
|bk_process_name|string|进程别名|
|bk_supplier_account|string|开发商账号|
|face_stop_cmd|string|强制停止命令|
|pid_file|string|PID 文件路径|
|priority|int|启动优先级|
|proc_num|int|启动数量|
|reload_cmd|string|进程重载命令|
|restart_cmd|string|重启命令|
|start_cmd|string|启动命令|
|stop_cmd|string|停止命令|
|timeout|int|操作超时时长|
|user|string|启动用户|
|work_path|string|工作路径|
|process_info|object|进程信息|

### 请求参数示例

```python
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "processes": [
    {
      "bk_process_id": 43,
      "bk_supplier_account": "0",
      "description": "",
      "start_cmd": "",
      "restart_cmd": "",
      "pid_file": "",
      "auto_start": false,
      "timeout": 30,
      "auto_time_gap": 60,
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
      "bk_func_id": "",
      "bind_info": [
        {
            "enable": false,  
            "ip": "127.0.0.1",  
            "port": "100",  
            "protocol": "1", 
            "template_row_id": 1  
        }
      ]
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
  "data": [43]
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
| data | object | 请求返回的数据 |