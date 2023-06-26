
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/gse/get_agent_info/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询 agent 心跳详细信息。数据非实时，延时 1 分钟内。

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 是     | 开发商账号 |
| hosts          |  array     | 是     | 主机列表 |

#### hosts

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_cloud_id |  int    | 是     | 云区域 ID |
| ip          |  string | 是     | IP 地址 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "0",
    "hosts": [
        {
            "ip": "10.0.0.1",
            "bk_cloud_id": 0
        }
    ]
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "0:10.0.0.1": {
            "ip": "10.0.0.1",
            "version": "V0.01R060D38",
            "bk_cloud_id": 0,
            "parent_ip": "10.0.0.2",
            "parent_port": 50000
        }
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| key                | string       | 格式为：bk_cloud_id:ip |
| value.ip           | string       | 主机 IP 地址 |
| value.bk_cloud_id  | int          | 云区域 ID |
| value.version      | string       | agent 版本号 |
| value.parent_ip    | string       | agent 的上级节点 ip |
| value.parent_port  | int          | agent 的上级节点端口 |