### 请求地址

/api/c/compapi/v2/itsm/create_ticket/

### 请求方法

POST

### 功能描述

创建单据接口

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_app_code | string | 是 | 应用 ID |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段 | 类型 | 必选 | 描述 |
| --------- | ------ | --- | -------------------------- |
| service_id | int | 是 | 服务 id |
| creator | string | 是 | 单据创建者 |
| fields | array | 是 | 提单字段 |

### 请求参数示例

```json
{
    "bk_app_secret": "xxxx",
    "bk_app_code": "xxxx",
    "bk_token": "xxxx",
    "service_id": 17,
    "creator": "xxx",
    "fields": [{
        "key": "title",
        "value": "d"
    }]
}
```

### 返回结果示例

```json
{
	"message": "success",
	"code": 0,
	"data": {
		"sn": "NO2019090519542603"
	},
    "result": true
}

```

### 返回结果参数说明

| 字段 | 类型 | 描述 |
| ------- | --------- | ----------------------- |
| result | bool | 返回结果，true 为成功，false 为失败 |
| code | int | 返回码，0 表示成功，其他值表示失败 |
| message | string | 错误信息 |
| data | object | 返回数据 |

### data

| 字段 | 类型 | 描述 |
| ---------| ------ | -------- |
| sn | string | 单号 |
