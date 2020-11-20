
### 请求地址

/api/c/compapi/v2/cc/search_host_lock/



### 请求方法

POST


### 功能描述

根据主机 id 列表查询主机锁(v3.8.6)

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                |  类型       | 必选   |  描述                            |
|---------------------|-------------|--------|----------------------------------|
|id_list| int array| 是|主机 ID 列表|


### 请求参数示例

```python
{
   "id_list":[1, 2]
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        1: true,
        2: false
    }
}
```

### 返回结果参数说明

#### data
| 字段      | 类型      | 描述         |
|-----------|-----------|--------------|
| data | map[int]bool | 请求返回的数据, key 是 ID，value 是否上锁 |