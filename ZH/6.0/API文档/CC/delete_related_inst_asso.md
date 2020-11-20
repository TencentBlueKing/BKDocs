
### 请求地址

/api/c/compapi/v2/cc/delete_related_inst_asso/



### 请求方法

POST


### 功能描述

 根据实例关联关系的 ID 删除实例之间的关联。(生效版本：3.5.40)

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


#### 接口参数

| 字段 | 类型     | 必选 | 描述             |
| :--- | :------- | :--- | :--------------- |
| id   | int | 是   | 实例关联关系的 ID， 最多 500 个 |

### 请求参数示例

```json
{
	"id":[1,2]
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "data": null
}
```

### 返回结果参数说明

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false 请求失败 |
| code | int | 错误编码。 0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| data | object | 请求返回的数据 |