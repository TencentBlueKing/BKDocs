
### 请求地址

/api/c/compapi/v2/usermanage/list_profile_departments/



### 请求方法

GET


### 功能描述

请求某个用户的部门信息

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


#### 接口参数 

| 字段      |  类型      | 必须   |  描述      |
|-----------|------------|--------|------------|
| lookup_field | 字符串 | 否 | 查询字段, 默认为 'username' |
| with_family | 布尔 | 否 | 结果是否返回部门树, 默认为否 |


### 请求参数示例

``` json
{
  "with_family": true
}
```

### 返回结果示例

```json
{
    "message": "Success",
    "code": 0,
    "data": [{
        "id": 4,
        "name": "PaaS",
        "family": [
           {"id": 5, "name": "BlueKing1"},
           {"id": 6, "name": "BlueKing2"},
        ]
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
|data| array| 结果 |