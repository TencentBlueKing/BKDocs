
### 请求地址

/api/c/compapi/v2/usermanage/list_department_profiles/



### 请求方法

GET


### 功能描述

请求某部门的用户信息

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


#### 接口参数 

|  字段     |  类型      |  必须  |  描述      |
|-----------|------------|--------|------------|
| lookup_field | 字符串 | 否 | 查询字段, 默认为 'id' |
| recursive | 布尔 | 否 | 是否级联查询部门用户,默认为否 |
| no_page | 布尔 | 否 | 是否不分页一次性返回所有结果，默认为否 |



### 请求参数示例

``` json
{
  "recursive": true
}
```

### 返回结果示例

```json
{
    "message": "Success",
    "code": 0,
    "data": [
        {"username":"GW67279","id":90909},
        {"username":"GW67280","id":90910},
        {"username":"GW67281","id":90911}
    ],
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型     | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true 为成功，false 为失败 |
|code|int|返回码，0 表示成功，其他值表示失败|
|message|string|错误信息|
|data| array| 结果 |