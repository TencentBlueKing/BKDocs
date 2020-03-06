### 请求地址

/api/c/compapi/v2/cc/add_host_lock/

### 请求方法

POST

### 功能描述

新加主机锁，如果主机已经加过锁，同样提示加锁成功

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|--------------|--------|----|------------|
| bk_app_code  | string | 是 | 应用 ID     |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段 | 类型 | 必选 | 描述 |
|---------|-------------|-----|-----------|
| ip_list | string array | 是 | 主机内网IP |
| bk_cloud_id | int | 否 | 云区域ID |


### 请求参数示例

```python
{
   "ip_list":["127.0.0.1"],
   "bk_cloud_id":0
}
```

### 返回结果示例

```python

{
    "result": true,
    "bk_error_code": 0,
    "bk_error_msg": "success",
    "data": null
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| result        | bool   | 请求成功与否，true:请求成功，false:请求失败 |
| bk_error_code | string | 组件返回错误编码 |
| bk_error_msg  | string | 请求失败返回的错误消息 |
| data          | object | 请求成功返回的数据 |
