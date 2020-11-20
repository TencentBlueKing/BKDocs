
### 请求地址

/api/c/compapi/v2/iam/authorization/batch_instance/



### 请求方法

POST


### 功能描述

资源实例授权回收

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
| asynchronous |  布尔  | 是   | 是否异步调用, 默认 否, 当前只支持同步 |
| operate |  字符串   | 是   | grant 或 revoke |
| system |  字符串  | 是   | 系统 id |
| actions |  数组[对象]   | 是   | 操作 |
| subject |  字符串   | 是   | 授权对象 |
| resources |  数组[对象]   | 是   | 资源实例 |

#### actions

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| id    |  字符串  | 是   | 操作 ID |

#### subject

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| type    |  字符串  | 是   | 授权对象类型, 当前只支持 user |
| id    |  字符串  | 是   | 授权对象 ID |

#### resources

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| instances | 数组[对象] | 是 | 批量实例信息 |

#### resources.instances

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| id | 字符串 | 是 | 资源实例 ID |
| name | 字符串 | 是 | 资源实例名称 |

### 请求参数示例

```python
{
  "asynchronous": false,  # 默认false, 当前只支持同步
  "operate": "grant",   # grant 授权 revoke 回收
  "system": "bk_cmdb",
  "actions": [  # 批量的操作
    {
      "id": "edit_host"
    }
  ],
  "subject": {  # 当前只能对user授权
    "type": "user",
    "id": "admin"
  },
  "resources": [  # 操作依赖多个资源类型的情况下, 表示一个组合资源
    {  # 操作关联的资源类型, 必须与所有的actions都匹配
      "system": "bk_cmdb",
      "type": "host",
      "instances": [  # 批量资源实例
        {
          "id": "1",
          "name": "host1"
        }
    }
  ]
}
```

### 返回结果示例

```python
{
  "code": 0,
  "message": "ok",
  "data": [
    {
      "action": {
        "id": "edit_host"
      },
      "policy_id": 1
    }
  ]
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| policy_id   | 数值     | 权限策略 id |
| action   | 对象     | 操作 |