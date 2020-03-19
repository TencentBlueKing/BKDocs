### 请求地址

/api/c/compapi/v2/job/get_script_detail/

### 请求方法

GET

### 功能描述

查询脚本详情

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_app_code | string | 是 | 应用 ID |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过Cookie获取 |
| bk_username | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段 | 类型 | 必选 | 描述 |
|----------------------|------------|--------|------------|
| bk_biz_id | int | 否 | 业务 ID，如果查询公共脚本可不传 |
| id | int | 是 | 脚本 ID |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "id": 18
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "id": 18,
        "name": "test",
        "version": "admin.20180723160606",
        "tag": "v1.0",
        "type": 1,
        "creator": "admin",
        "content": "xxx",
        "public": false,
        "bk_biz_id": 1,
        "create_time": "2018-07-23 16:06:06",
        "last_modify_user": "admin",
        "last_modify_time": "2018-07-23 16:06:08"
    },
}
```

### 返回结果参数说明

| 字段 | 类型 | 描述 |
|-----------|-----------|-----------|
| result | bool | 请求成功与否，true:请求成功，false:请求失败 |
| code | string | 组件返回错误编码，0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误消息 |
| data | object | 请求返回的数据 |


#### data

| 字段 | 类型 | 描述 |
|-----------|-----------|-----------|
| id | int | 脚本 ID |
| name | string | 脚本名称 |
| version | string | 脚本版本号 |
| tag | string | 脚本版本备注 |
| type | int | 脚本类型 |
| creator | string | 脚本创建人 |
| public | bool | 是否公共脚本 |
| bk_biz_id | int | 业务 ID |
| create_time | string | 脚本创建时间 |
| last_modify_user| string | 脚本最近一次修改人 |
| last_modify_time| string | 脚本最近一次修改时间 |
| content | string | 脚本内容 |
