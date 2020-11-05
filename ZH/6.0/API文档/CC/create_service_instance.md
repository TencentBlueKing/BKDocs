
### 请求地址

/api/c/compapi/v2/cc/create_service_instance/



### 请求方法

POST


### 功能描述

批量创建服务实例，如果模块绑定了服务模板，则服务实例也会根据模板创建，创建服务实例的进程参数内也必须提供每个进程对应的进程模板ID

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                 |  类型      | 必选	   |  描述                 |
|----------------------|------------|--------|-----------------------|
| bk_module_id         | int  | 否   | 模块ID |
| instances            | array  | 是   | 需要创建的服务实例信息|

#### instances 字段说明

| 字段|类型|说明|Description|
|---|---|---|---|
|instances.bk_host_id|int|主机ID|服务实例绑定的主机ID|
|instances.processes|array|进程信息|服务实例下新建的进程信息|
|instances.processes.process_template_id|int|进程模板ID|如果模块没有绑定服务模板则填0|
|instances.processes.process_info|object|进程实例信息|如果进程绑定有模板，则仅模板中没有锁定的字段有效|

### 请求参数示例

```python
{
  "bk_biz_id": 1,
  "name": "test1",
  "bk_module_id": 60,
  "instances": [
    {
      "bk_host_id": 2,
      "processes": [
        {
          "process_template_id": 1,
          "process_info": {
            "bk_supplier_account": "0",
            "bind_ip": "1",
            "description": "",
            "start_cmd": "",
            "restart_cmd": "",
            "pid_file": "",
            "auto_start": false,
            "timeout": 30,
            "protocol": "1",
            "auto_time_gap": 60,
            "reload_cmd": "",
            "bk_func_name": "java",
            "work_path": "/data/bkee",
            "stop_cmd": "",
            "face_stop_cmd": "",
            "port": "8008,8443",
            "bk_process_name": "job_java",
            "user": "",
            "proc_num": 1,
            "priority": 1,
            "bk_biz_id": 2,
            "bk_func_id": "",
            "bk_process_id": 1
          }
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
  "data": [53]
}
```

### 返回结果参数说明

#### response

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false请求失败 |
| code | int | 错误编码。 0表示success，>0表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| data | object | 新建的服务实例ID列表 |