
### 请求地址

/api/c/compapi/v2/monitor/query_data/



### 请求方法

POST


### 功能描述

图表数据查询  
根据给定的sql表达式查询指定的存储引擎  



#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段           | 类型   | 必选 | 描述        |
| -------------- | ------ | ---- | ----------- |
| sql            | string | 是   | SQL查询语句 |
| prefer_storage | string |      | 查询引擎    |

#### 请求示例

```json
{
    "username":"admin",
    "sql":"select max(in_use) as _in_use from 3_system_disk where time >= \"1m\" group by ip, plat_id, company_id, device_name, minute1 order by time desc limit 1"
}
```

### 返回结果

#### 字段说明

| 字段                | 类型   | 描述     |
| ------------------- | ------ | -------- |
| list                | list   | 查询结果 |
| select_fields_order | list   | 查询字段 |
| totalRecords        | int    | 总记录数 |
| timetaken           | float  | 查询耗时 |
| cluster             | string | 集群名称 |
| device              | string | 查询引擎 |

#### 结果示例

```json
{
    "message":"OK",
    "code":"0",
    "data":{
        "list":[
            {
                "ip":"10.0.4.5",
                "time":1543487700000,
                "company_id":"0",
                "device_name":"C:",
                "_in_use":27.0269684761,
                "plat_id":"0",
                "minute1":1543487700000
            },
            {
                "ip":"10.0.4.13",
                "time":1543487700000,
                "company_id":"0",
                "device_name":"\/",
                "_in_use":8.3368418991,
                "plat_id":"0",
                "minute1":1543487700000
            }
        ],
        "timetaken":0.0059459209,
        "totalRecords":2,
        "cluster":"default",
        "device":"tsdb",
        "select_fields_order":[
            "_in_use",
            "ip",
            "plat_id",
            "company_id",
            "device_name",
            "minute1"
        ]
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```