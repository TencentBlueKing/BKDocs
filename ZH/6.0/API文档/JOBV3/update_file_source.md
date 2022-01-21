### 功能描述

更新文件源

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段             |  类型      | 必选   |  描述       |
|-----------------|------------|--------|------------|
| bk_biz_id       |  long      | 是     | 业务 ID     |
| id              |  int       | 否     | 文件源 ID，与 code 二者至少填一个，同时填写以 id 为准 |
| code            |  string    | 否     | 文件源标识，与 id 二者至少填一个，同时填写以 id 为准，英文字符开头，1-32 位英文字符、下划线、数字组成，创建后不可更改 |
| alias           |  string    | 否     | 文件源别名 |
| type            |  string    | 否     | 文件源类型，当前仅支持蓝鲸制品库，BLUEKING_ARTIFACTORY |
| access_params   |  object    | 否     | 文件源接入参数，根据 type 传入不同的对象，见后续说明 |
| credential_id   |  string    | 否     | 文件源使用的凭据 Id |
| file_prefix     |  string    | 否     | Job 对从该文件源分发的文件加上的前缀，不传默认不加前缀 |

### access_params
**type 为 BLUEKING_ARTIFACTORY**  

| 字段             |  类型      | 必选   |  描述       |
|-----------------|------------|--------|------------|
| base_url        |  string    | 是     | 对接的制品库实例根地址，例如：https://bkrepo.com |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "code": "sopsArtifactory",
    "alias": "标准运维制品库文件源",
    "type": "BLUEKING_ARTIFACTORY",
    "access_params": {
        "base_url": "https://bkrepo.com"
    },
    "credential_id": "06644309e10e4068b3c7b32799668210",
    "file_prefix": ""
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "id": 1
    }
}
```

### 返回结果参数说明

#### data

| 字段        | 类型    |字段是否一定存在  | 描述      |
|------------|--------|---------------|-----------|
| id         | int    |是              | 文件源 ID |
