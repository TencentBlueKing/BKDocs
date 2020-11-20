
### 请求地址

/api/c/compapi/v2/job/operate_step_instance/



### 请求方法

POST


### 功能描述

用于对执行的实例的步骤进行操作，例如重试，忽略错误等。

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id   |  long       | 是     | 业务 ID |
| job_instance_id   |  long       | 是     | 作业实例 ID |
| step_instance_id |  long     | 是     | 步骤实例 ID |
| operation_code |  int     | 是     | 操作类型：2、失败 IP 重做，3、忽略错误，4、执行，5、跳过，6、确认继续 8、全部重试，9、终止确认流程，10-重新发起确认 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "job_instance_id": 100,
	"step_instance_id": 200,
	"operation_code": 2
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "step_instance_id": 200,
        "job_instance_id": 100
    }
}
```