
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/usermanage/list_department_profiles/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

请求某部门的用户信息

### 请求参数




#### 接口参数 

|  字段     |  类型      |  必须  |  描述      |
|-----------|------------|--------|------------|
| id | 字符串 | 是 | 部门 ID |
| lookup_field | 字符串 | 否 | 查询字段, 默认为 'id' |
| recursive | 布尔 | 否 | 是否级联查询部门用户,默认为否 |



### 请求参数示例

``` json
{
  "bk_app_code": "xxx",
  "bk_app_secret": "xxx",
  "bk_token": "xxx",
  "bk_username": "xxx",
  "id": 1,
  "lookup_field": "id",
  "recursive": true
}
```

### 返回结果示例

仅示意，请以实际请求结果为准
```json
{
    "message": "Success",
    "code": 0,
    "data": [{
      "id":1,
      "username":"admin",
      "departments":[],
      "extras":{},
      "leader":[]
    }],
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型     | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true 为成功，false 为失败 |
|code|int|返回码，0 表示成功，其他值表示失败|
|message|string|错误信息|
|data| array| 结果，根据请求参数动态返回，可以参考上述返回结果示例 |

**data** 字段简析

| 字段      | 类型     | 描述      |
|-----------|-----------|-----------|
|id| int | 用户 ID |
|username|string| 用户名 |
|departments|array| 用户关联的部门列表 |
|extras| dict | 用户扩展字段 |
|leader| array| 用户关联上级 |