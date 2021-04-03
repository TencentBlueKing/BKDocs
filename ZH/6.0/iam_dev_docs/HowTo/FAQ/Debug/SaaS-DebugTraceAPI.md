# IAM SaaS Debug Trace 接口

# 1. 背景

为了方便客户快速定位错误信息, 降低问题定位的沟通成本, 权限中心 SaaS 提供了快速查询 Debug Trace 的相关接口

客户在发现 SaaS 使用过程中出现`未知错误`, 可以通过`request_id`查询到相关的调试信息, 提单时附加到单据中

如果发现后台定时任务出现异常也可以通过`task_id`查询到相关的调试信息, 如果找不到`task_id`, 可以通过**日期**来查询所有当天任务执行的调试信息

# 2. 接口认证

以下接口使用`HTTP Basic authentication`认证方式, 用户名: IAM SaaS 的`app_code`, 密码: IAM SaaS 的`app_secret`

# 3. 协议

## 3.1 通过 request_id/task_id 查询调试跟踪信息

#### URL

> GET http://{iam_saas_api_host}/api/v1/debug/{request_id/task_id}/

#### Parameters

|字段 |类型 |是否必须 |位置 |描述 |
|:--:|:--:|:--:|:--:|:--:|
|request_id/task_id |string |是 |path |请求 id/任务 id |

#### Response
```json
# 请求debug信息数据
{
  "data": {
    "id": "205310e3fe5548059ad386d7969b8161",  # request_id
    "type": "api",
    "path": "/api/v1/accounts/user/",  #  请求path
    "method": "post",  # 请求method
    "data": {},  # request data
    "exc": "",  # 异常信息
    "stack": [],  # 调用链信息
  },
  "result": true,
  "code": 0,
  "message": "OK"
}

# celery任务debug信息
{
  "data": {
    "id": "cdc04cd3-c91f-4a98-9772-f237e313e90c",  # 任务id
    "type": "task",
    "name": "backend.apps.role.tasks.role_group_expire_remind",  # 任务名称
    "exc": "",  # 异常信息
    "stack": [],  # 调用链信息
  },
  "result": true,
  "code": 0,
  "message": "OK"
}
```

## 3.2 通过日期查询后台任务调试跟踪信息

#### URL

> GET http://{iam_saas_api_host}/api/v1/debug/?day={day}

#### Parameters

|字段 |类型 |是否必须 |位置 |描述 |
|:--:|:--:|:--:|:--:|:--:|
|day |string |是 |query_string |日期, 例如 20210101 |

#### Response
```json
{
  "data": [
      {
        "id": "cdc04cd3-c91f-4a98-9772-f237e313e90c",
        "type": "task",
        "name": "backend.apps.role.tasks.role_group_expire_remind",
        "exc": "",
        "stack": [],
      }
  ]
  "result": true,
  "code": 0,
  "message": "OK"
}
```