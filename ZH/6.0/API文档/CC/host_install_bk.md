### 功能描述

安装主机到蓝鲸业务下, 详情如下:
1. 只能操作蓝鲸业务 
2. 不能将主机转移到空闲机和故障机等内置模块
3. 不会删除主机已经存在的主机模块， 只会新加主机与模块。 
4. 不存在的主机会新加， 规则通过内网 IP 和 cloud id 判断主机是否存在
5. 进程不存在不报错

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                 |  类型      | 必选	   |  描述                 |
|----------------------|------------|--------|-----------------------|
| bk_set_name  | string     |是     | 主机所在的集群名 |
| bk_module_name | string  | 是   | 主机所在的模块名 |
| bk_host_innerip | string  | 是   | 主机内网 IP |
| bk_cloud_id | int  | 否   | 主机所在的云区域，默认值 0  |
| host_info | object  | 否   | 主机详细，主机模型的所有字段和值得对应 |
| proc_info | object |否| 主机在当前模块下服务实例中进程的值, {"进程名":{"进程属性":值}}, 参考进程模型|


### 请求参数示例

```json

{
        "bk_set_name":"set1",
        "bk_module_name":"module2",
        "bk_host_innerip":"127.0.0.1",
        "bk_cloud_id":0,
        "host_info":{
                "bk_comment":"test bk_comment 1",
                "bk_os_type":"1"
        },
        "proc_info":{
                "p1":{"description":"xxx"}
        }
}

```

### 返回结果示例

```json
{
  "result": true,
  "code": 0,
  "message": "success",
}
```

### 返回结果参数说明

#### response

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false 请求失败 |
| code | int | 错误编码。 0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误信息 |


