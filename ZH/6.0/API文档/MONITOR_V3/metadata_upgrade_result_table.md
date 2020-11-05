
### 请求地址

/api/c/compapi/v2/monitor_v3/metadata_upgrade_result_table/



### 请求方法

POST


### 功能描述

修改一个单业务结果表，使之升级为全业务结果表



#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段           | 类型   | 必选 | 描述        |
| -------------- | ------ | ---- | ----------- |
| table_id  | string | 是   | 结果表ID |
| operator | string | 是 | 操作者  | 

#### 请求示例

```json
{
	"table_id_list": ["2_system.cpu", "3_system.cpu"],
}
```

### 返回结果

#### 结果示例

```json
{
    "message":"OK",
    "code":"0",
    "data": null,
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```