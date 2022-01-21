### 功能描述

注册插件信息

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |




#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| name | string | 是 | 插件名 |
| description | string | 是 | desc |
| scenario | string | 是 | 使用场景 |
| category | string | 是 | 类别 |
| config_file | string | 是 | 配置文件名 |
| config_file_format | string | 是 | 配置文件格式 |
| use_db | string | 是 | 是否使用 db |
| is_binary | string | 是 | 是否二进制 |

### 请求参数示例

``` json
{
    "name": "xxxxx",
    "description": "用于采集主机基础性能，包含CPU内存，磁盘，网络等数据的程序",
    "scenario": "CMDB上的实时数据，蓝鲸监控里的主机监控中的基础性能数据",
    "category": "offical",
    "config_file": "config.json",
    "config_file_format": 'json',
    "use_db": 0,
    "is_binary" 0 
}

```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message":"success",
    "data": []
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true 为成功，false 为失败 |
|code|int|返回码，0 表示成功，其他值表示失败|
|message|string|错误信息
|data| array| 结果 |