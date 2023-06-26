
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/usermanage/retrieve_department/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询部门具体信息

### 请求参数




#### 接口参数

| 字段      |  类型      | 必须   |  描述      |
|-----------|------------|--------|------------|
| id | 字符串 | 是 | 查询目标组织的 id，例如 1122 |
| fields | 字符串 | 否 | 返回字段, 例如 "name,id" |


### 请求参数示例 

查找 id 为 1122 的组织，只返回 name、id 字段
``` json
{
  "bk_app_code": "xxx",
  "bk_app_secret": "xxx",
  "bk_token": "xxx",
  "bk_username": "xxx",
  "id": 1122,
  "fields": "name,id"
}
```

### 返回结果示例 

仅示意，请以实际请求结果为准
```json
{
    "message": "Success",
    "code": 0,
    "data": {
      "id":1,
      "name":"总公司",
      "has_children":true,
      "full_name":"总公司",
      "children":[],
      "parent":null
    },
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型     | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true 为成功，false 为失败 |
|code|int|返回码，0 表示成功，其他值表示失败|
|message|string|错误信息|
|data| array| 结果，请参照返回结果示例 | 

**data** 字段简析（具体字段取决于参数 `fields`）

| 字段      | 类型     | 描述      |
|-----------|-----------|-----------|
|id| int | 部门 ID |
|name|string| 部门名 |
|has_children|bool| 是否包含子部门 |
|full_name| string | 部门完整路径 |
|children| array| 用户关联子部门 |
|parent| object | 该部门的父部门 |