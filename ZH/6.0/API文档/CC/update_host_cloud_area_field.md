### 功能描述

根据主机 id 列表和云区域 id,更新主机的云区域字段

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                 |  类型      | 必选	   |  描述                 |
|----------------------|------------|--------|-----------------------|
| bk_biz_id            | int  | 否   | 业务 ID |
| bk_cloud_id         | int  | 是   | 云区域 ID |
| bk_host_ids         | array  | 是   | 主机 IDs, 最多 2000 个 |


### 请求参数示例

```json
{
	"bk_host_ids": [43, 44], 
	"bk_cloud_id": 27,
	"bk_biz_id": 1
}
```

### 返回结果示例

```json
{
  "result": true,
  "code": 0,
  "message": "success",
  "permission": null,
  "data": ""
}
```

### 返回结果实例 - 云区域 + 内网 IP 重复

```json
{
  "result": false,
  "code": 1199014,
  "message": "数据唯一性校验失败， bk_host_innerip 重复",
  "permission": null,
  "data": null
}
```

### 返回结果实例 - 一次操作主机数太多
```json
{
  "result": false,
  "code": 1199077,
  "message": "一次操作记录数超过最大限制：2000",
  "permission": null,
  "data": null
}
```

```plain

### 返回结果参数说明

#### response

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false请求失败 |
| code | int | 错误编码。 0表示success，>0表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| data | object | 无数据返回 |
