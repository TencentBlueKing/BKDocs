### 请求地址

/api/c/compapi/cmsi/get_msg_type/

### 请求方法

GET

### 功能描述

查询 send_msg 组件支持发送消息的类型

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|--------------|--------|----|------------|
| bk_app_code | string | 是 | 应用 ID |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx"
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "data": [
        {
            "type": "weixin",
            "label": "微信",
            "is_active": true
        },
        {
            "type": "mail",
            "label": "邮件",
            "is_active": true
        },
        {
            "type": "sms",
            "label": "短信",
            "is_active": true
        },
        {
            "type": "voice",
            "label": "语音",
            "is_active": true
        }
    ]
}
```

### 返回结果参数说明

| 字段 | 类型 | 描述 |
|--------|--------|-----------|
| result | bool | 请求成功与否，true:请求成功，false:请求失败 |
| code | string | 组件返回错误编码，0 表示 success，>0 表示失败错误 |
| data | object | 请求返回的数据 |

#### data

| 字段 | 类型 | 描述 |
|-----------|--------|-----------|
| type | string | 消息发送类型 |
| label | string | 消息发送标签 |
| is_active | bool | 可用性 |
