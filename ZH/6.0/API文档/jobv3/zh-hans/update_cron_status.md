
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/jobv3/update_cron_status/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

更新定时作业状态，如启动或暂停

### 请求参数



#### 接口参数

| 字段        |  类型      | 必选   |  描述      |
|----------- |------------|--------|------------|
| bk_biz_id  |  long      | 是     | 业务 ID |
| id         |  long      | 是     | 定时作业 ID |
| status     |  int       | 是     | 定时状态，1.启动、2.暂停 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "id": 2,
    "status": 1
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": 2
}
```