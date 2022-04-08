
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/usermanage/list_profile_departments/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

请求某个用户的部门信息

### 请求参数




#### 接口参数 

| 字段      |  类型      | 必须   |  描述      |
|-----------|------------|--------|------------|
| id | 字符串 | 是 | 用户 ID |
| lookup_field | 字符串 | 否 | 查询字段, 默认为 'username' |
| with_family | 布尔 | 否 | 结果是否返回部门树, 默认为否 |


### 请求参数示例

``` json
{
  "bk_app_code": "xxx",
  "bk_app_secret": "xxx",
  "bk_token": "xxx",
  "bk_username": "xxx",
  "id": 1,
  "lookup_field": "username"
}
```

### 返回结果示例

 仅示意，请以实际请求结果为准
```json
{
    "message": "Success",
    "code": 0,
    "data": [{
        "id": 4,
        "name": "admin",
        "children": []
    }],
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型     | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true为成功，false为失败 |
|code|int|返回码，0表示成功，其他值表示失败|
|message|string|错误信息|
|data| array| 结果，请参照返回结果示例 | 

**data** 字段简析

| 字段      | 类型     | 描述      |
|-----------|-----------|-----------|
|id| int | 部门 ID |
|name|string| 部门名 |
|has_children|bool| 是否包含子部门 |
|full_name| string | 部门完整路径 |
|children| array| 用户关联子部门 |
|parent| dict | 该部门的父部门 |