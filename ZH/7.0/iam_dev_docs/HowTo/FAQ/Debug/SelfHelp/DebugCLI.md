# IAM-Debug CLI

## 1. 背景

在部署和运维权限中心的过程中, 可能会定位一些问题

如果通过查询数据库/日志/报错信息等方式, 那么整个问题排查成本会非常高

基于这个原因, 我们开发了`debug-cli`, 服务提供了相应的 debug api, 通过 cli 可以直接查询获取得到相关的信息(例如不需要自行去查询多个表拼凑信息, debug api 直接组合查询)

通过`debug-cli`, 运维可以按照文档步骤, 一步步执行, 获取结果, 通过结果快速定位问题.

## 2. 使用简介

```bash
$ ./iam-cli help
A command tool for IAM debug.
You can use it to query the system model, policy data, user data, cache as so on.

Usage:
  iam-cli [command]

Available Commands:
  cache       Query policy or expression from cache
  healthz     call /healthz to check if the iam backend service is health
  help        Help about any command
  login       Login via app_code/app_secret of IAM
  ping        call /ping to check if the iam backend service is alive
  query       Query data of model/action/subject/policy
  use         The current system you want to query
  version     call /version to check the version of iam backend

Flags:
      --config string   config file (default is $HOME/.iam-cli.yaml)
  -h, --help            help for iam-cli
  -t, --toggle          Help message for toggle

Use "iam-cli [command] --help" for more information about a command.
```

## 3. 使用示例

### 3.1 登录 login

> ./iam-cli login http://{iam_host} {app_code} {app_secret}

```bash
$ ./iam-cli login http://{bkiam_address} bk_iam {bk_iam_saas_app_secret}
INFO: success
```

### 3.2 确认基本服务可用

> ./iam-cli [ping | version | healthz]

分别确定服务可达/版本号/是否健康

```bash
$ ./iam-cli ping
INFO: pong

$ ./iam-cli version
INFO: success
{
  "buildTime": "2021-01-15_05:50:01",
  "commit": "61a8cb2b2978c72c509ceb264fbfb7620a98173c",
  "env": "",
  "goVersion": "go version go1.14 linux/amd64",
  "version": "1.5.9"
}

$ ./iam-cli healthz
INFO: ok
```

### 3.3 切换系统

> ./iam-cli use {system_id}

```bash
$ ./iam-cli use bk_paas
INFO: success
```

### 3.4 查询系统注册的权限模型

> ./iam-cli query [model | action]

```bash
$  ./iam-cli query model

$ ./iam-cli query action
```

### 3.5 查询某个 subject 在系统下某个操作的 policy

> ./iam-cli query policy {subject_type} {subject_id} {action_id}

```bash
./iam-cli query policy user admin access_developer_center
{
  "field": "",
  "op": "any",
  "value": []
}
```

### 3.6 查询某个 subject

> ./iam-cli query subject {subject_type} {subject_id}

```bash
$ ./iam-cli query subject group 1
{
  "departments": [],
  "errs": {},
  "groups": null,
  "subject": {
    "id": "1",
    "pk": 43325,
    "type": "group"
  }
}

$ ./iam-cli query subject user test1
```

### 3.7 查询缓存内的 policy 和 expression

> ./iam-cli cache policy {subject_type} {subject_id}                    # list all actions
> ./iam-cli cache policy {subject_type} {subject_id} {action_id}  # get one action
> ./iam-cli cache expression exprPK1 exprPK2 ...

```bash
$ ./iam-cli cache policy group 1 access_developer_center
{
  "action_pk": 347,
  "errs": [
    null,
    null
  ],
  "expressions": [],
  "notInCache": false,
  "policies": [],
  "subject_pk": 43325
}

./iam-cli cache expression 351 347
{
  "err": null,
  "expressions": null,
  "noCachePKs": [
    351,
    347
  ],
  "pks": [
    351,
    347
  ]
}
```

### 3.8 SaaS 登录 login

> ./iam-cli saas login http://{iam_saas_host} {app_code} {app_secret}

```bash
$ ./iam-cli saas login http://{bkiam_saas_address} bk_iam {bk_iam_saas_app_secret}
INFO: success
```

### 3.9 确认 SaaS 可用

> ./iam-cli saas ping

去掉 SaaS 可达

```bash
$ ./iam-cli saas ping
INFO: pong
```

### 3.10 查询 SaaS 的 Debug 信息列表

> ./iam-cli saas debug list 20210101

查询`20210101`这一天 SaaS 的所有 debug 信息

```bash
$ ./iam-cli saas debug list 20210101
[
  {
    "id": "cdc04cd3-c91f-4a98-9772-f237e313e90c",
    "type": "task",
    "name": "backend.apps.role.tasks.role_group_expire_remind",
    "exc": "",
    "stack": [],
  }
]
```

### 3.11 通过 request_id/task_id 查询单个请求的 Debug 信息

> ./iam-cli saas debug get {request_id/task_id}

通过请求 ID 或者 Celery Task ID 查询 Debug 信息

```bash
$ ./iam-cli saas debug get 205310e3fe5548059ad386d7969b8161
{
  "id": "205310e3fe5548059ad386d7969b8161",  # request_id
  "type": "api",
  "path": "/api/v1/accounts/user/",  #  请求path
  "method": "post",  # 请求method
  "data": {},  # request data
  "exc": "",  # 异常信息
  "stack": [],  # 调用链信息
}
```
