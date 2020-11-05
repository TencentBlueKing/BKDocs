
### 请求地址

/api/c/compapi/v2/cc/list_process_instance/



### 请求方法

POST


### 功能描述

根据服务实例ID查询进程实例列表

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
| service_instance_id | int  | 是   | 服务实例ID |


### 请求参数示例

```python
{
  "bk_biz_id": 1,
  "service_instance_id": 54
}
```

### 返回结果示例

```python
{
  "result": true,
  "code": 0,
  "message": "success",
  "data": [
    {
      "property": {
        "auto_start": false,
        "auto_time_gap": 60,
        "bk_biz_id": 2,
        "bk_func_id": "",
        "bk_func_name": "java",
        "bk_process_id": 46,
        "bk_process_name": "job_java",
        "bk_start_param_regex": "",
        "bk_supplier_account": "0",
        "create_time": "2019-06-05T14:59:12.065+08:00",
        "description": "",
        "face_stop_cmd": "",
        "last_time": "2019-06-05T14:59:12.065+08:00",
	      "bk_biz_id": 1,
        "pid_file": "",
        "priority": 1,
        "proc_num": 1,
        "reload_cmd": "",
        "restart_cmd": "",
        "start_cmd": "",
        "stop_cmd": "",
        "timeout": 30,
        "user": "",
        "work_path": "/data/bkee",
        "bind_info": [
            {
                "enable": false,  
                "ip": "127.0.0.1",  
                "port": "100",  
                "protocol": "1", 
                "template_row_id": 1  
            }
        ]
      },
      "relation": {
	      "bk_biz_id": 1,
        "bk_process_id": 46,
        "service_instance_id": 54,
        "process_template_id": 1,
        "bk_host_id": 1,
        "bk_supplier_account": ""
      }
    }
  ]
}
```

### 返回结果参数说明

#### response

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false请求失败 |
| code | int | 错误编码。 0表示success，>0表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| data | array | 请求返回的数据 |

#### data 字段说明

| 字段|类型|说明|Description|
|---|---|---|---|
|property|object|进程属性信息||
|relation|object|进程与服务实例的关联信息||


#### data.info[x].property.bind_info[n] 字段说明
| 字段|类型|说明|
|---|---|---|---|
|enable|bool|端口是否启用||
|ip|string|绑定的ip||
|port|string|绑定的端口||
|protocol|string|使用的协议||
|row_id|int|实例化使用的模板行索引，进程内唯一|