
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/monitor_v3/get_ts_data/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

图表数据查询 
根据给定的 sql 表达式查询指定的存储引擎  

### 请求参数



#### 接口参数

| 字段           | 类型   | 必选 | 描述        |
| -------------- | ------ | ---- | ----------- |
| sql            | string | 是   | SQL 查询语句 |
| prefer_storage | string | 否   | 查询引擎(默认 influxdb)    |
| bk_username    | string | 否   | 白名单的 app_code 必填      |

#### 请求示例

```json
{
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "bk_username":"admin",
    "sql":"select max(in_use) as _in_use from 3_system.disk where time >= \"1m\" group by ip, bk_cloud_id, bk_supplier_id, device_name, minute1 order by time desc limit 1"
}
```

>sql 中的结果表名为 biz_id + db_name + table_name  
>
>Biz_id：业务 id  
>Db_name: 数据库名  
>Table_name: 数据表名  
>例：2_system.cpu_detail：业务 2 下的 system 库的 cpu_detail 表  
>查询一个小时内的单核 cpu 的使用率的 sql 语句：  
>Select Mean(usage) as usage from 2_system.cpu_detail where time > '1h' group by ip,device_name,minute1 limit 10  

>上面请求实例中结果表 3_system.disk 表示：业务 3 下的 system 库中的 disk 表  

>注意：上述的库和表并非和时序存储中的实际物理库、表对应。而是指'源数据管理模块'的库表

### 返回结果

| 字段       | 类型   | 描述               |
| ---------- | ------ | ------------------ |
| result     | bool   | 请求是否成功       |
| code       | int    | 返回的状态码       |
| message    | string | 描述信息           |
| data       | list   | 更新成功的策略 id 表 |
| request_id | string | 请求 id             |

#### data 字段说明

| 字段         | 类型   | 描述     |
| ------------ | ------ | -------- |
| list         | list   | 查询结果 |
| totalRecords | int    | 总记录数 |
| timetaken    | float  | 查询耗时 |
| device       | string | 查询引擎 |

#### data.list

这里面的内容就是 sql 查找的相关内容

#### 结果示例

```json
{
    "message":"OK",
    "code":200,
    "data":{
        "list":[
            {
                "ip":"x.x.x.x",
                "time":1543487700000,
                "bk_supplier_id":"0",
                "device_name":"C:",
                "_in_use":27.0269684761,
                "bk_cloud_id":"0",
                "minute1":1543487700000
            },
            {
                "ip":"x.x.x.x",
                "time":1543487700000,
                "bk_supplier_id":"0",
                "device_name":"\/",
                "_in_use":8.3368418991,
                "bk_cloud_id":"0",
                "minute1":1543487700000
            }
        ],
        "timetaken":0.0059459209,
        "totalRecords":2,
        "device":"influxdb"
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```
