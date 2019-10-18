
### 请求地址

/api/c/compapi/v2/cc/create_set/



### 请求方法

POST


### 功能描述

创建集群

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 否     | 开发商账号 |
| bk_biz_id      | int     | 是     | 业务ID |
| data           | dict    | 是     | 集群数据 |

#### data

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_parent_id        |  int     | 是     | 父节点的ID |
| bk_set_name         |  string  | 是     | 集群名字 |
| default             |  int     | 否     | 0-普通集群，1-内置模块集合，默认为0 |

**注意：其它需要的字段由模型定义**

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 1,
    "data": {
        "bk_parent_id": 1,
        "bk_set_name": "test-set",
        "bk_set_desc": "test-set",
        "bk_capacity": 1000,
        "description": "description"
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
        "bk_set_id": 1
    }
}
```