
### 请求地址

/api/c/compapi/v2/cc/create_module/



### 请求方法

POST


### 功能描述

创建模块

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 否     | 开发商账号 |
| bk_biz_id      | int     | 是     | 业务 ID |
| bk_set_id      | int     | 是     | 集群 id |
| data           | dict    | 是     | 业务数据 |

#### data

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_parent_id      | int     | 是     | 父实例节点的 ID，当前实例节点的上一级实例节点，在拓扑结构中对于 module 一般指的是 set 的 bk_set_id |
| bk_module_name    | string  | 是     | 模块名 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 1,
    "bk_set_id": 10,
    "data": {
        "bk_parent_id": 10,
        "bk_module_name": "test"
    }
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "bk_module_id": 10
    }
}
```

### 返回结果参数说明

 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| result    | bool      | 请求成功与否，true:请求成功，false:请求失败 |
| code      | string    | 组件返回错误编码 |
| message   | string    | 请求失败返回的错误消息 |
| data      | object    | 请求成功返回的数据 |

#### data

| 字段       | 类型      | 描述     |
|----------- |-----------|----------|
| bk_module_id | int     | 模块id   |
