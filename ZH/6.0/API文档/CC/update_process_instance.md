
### 请求地址

/api/c/compapi/v2/cc/update_process_instance/



### 请求方法

POST


### 功能描述

批量更新进程信息

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
| processes            | array  | 是   | 进程信息 |



### 请求参数示例

```python
{
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
      ],
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
  "data": [43]
}
```

### 返回结果参数说明

#### response

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false请求失败 |
| code | int | 错误编码。 0表示success，>0表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| data | object | 请求返回的数据 |