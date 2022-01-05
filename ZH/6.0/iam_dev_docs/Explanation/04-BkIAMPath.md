# 资源拓扑`_bk_iam_path_`说明

> 本文重点阐述`_bk_iam_path_`的概念及开发者如何配置及使用

## 背景

如果系统使用`拓扑层级`来管理权限, 就会涉及到`实例视图`(拓扑层级意味着实例视图是多层的)

此时, 
1. 在鉴权等请求权限中心的接口中, 需要构造并传递资源的`_bk_iam_path_`
2. 用户在权限中心页面配置权限的时候, 权限中心会回调接入系统的接口请求资源信息, 实例接口需要返回实例的`_bk_iam_path_`

**注意: 如果操作配置了实例视图, 并且实例视图是多层的, 那么必须构造并传递`_bk_iam_path_`**

相关文档: 
* [说明: 实例视图](./01-InstanceSelection.md)
* [样例 3: 使用拓扑层级管理权限](../HowTo/Examples/03-Topology.md)
* [资源反向拉取 API](../Reference/API/03-Callback/01-API.md)

## `_bk_iam_path_`是什么

`_bk_iam_path_`是权限中心对`拓扑路径`的一种表达形式; 

相当于一个资源实例的拓扑

如果一台主机`192.168.1.1`
- 属于`业务 A 下的集群 B 下的主机`, 那么此时其`_bk_iam_path_=["/biz,A/cluster,B/"]`; 
- 如果这个机器又同时属于集群 C, 那么其`_bk_iam_path_=["/biz,A/cluster,B/", "/biz,A/cluster,C/"]`

## 格式及内容

- key: `_bk_iam_path_`
- value: `["/ParentType1,parentType1InstancA/ParentType2,parentType2InstanceB/", ...]`

## 示例

标准运维的任务查看为例
- 操作: `任务查看`(`action=task_view`)
- 关联资源类型 resource_type 为 `任务`(`system_id=bk_sops; id=task`)
- 在配置权限的时候, 这个 task 的选择是通过实例视图 instance_selection 为 `任务实例视图`(`system_id=bk_sops, id=task`) 选择出来的;
- 任务实例视图(`system_id=bk_sops, id=task`) 有两层:  `system_id=bk_sops, id=project` / `system_id=bk_sops, id=task`, 表示 `项目下的任务`

```json
# action model
{
  "id": "task_view",
  "name": "任务查看",
  "name_en": "Task View",
  "description": "",
  "description_en": "",
  "type": "view",
  "related_resource_types": [
    {
      "system_id": "bk_sops",
      "id": "task",
      "selection_mode": "all",
      "related_instance_selections": [
        {
          "system_id": "bk_sops",
          "id": "task"
        }
      ]
    }
  ],
  "version": 1
}
# instance selection model
{
  "id": "task",
  "name": "任务实例",
  "name_en": "Task",
  "resource_type_chain": [
    {
      "system_id": "bk_sops",
      "id": "project"
    },
    {
      "system_id": "bk_sops",
      "id": "task"
    }
  ]
}
```

![-w2021](../assets/Explanation/01_instance_selection_03.png)

如果勾选了 `项目蓝鲸下的任务test`

```bash
task.id eq test
AND
task._bk_iam_path_ starts_with /project,蓝鲸ProjectID/
```

如果勾选了 `项目蓝鲸`, 代表项目蓝鲸下的所有任务都有权限, **包括未来在项目蓝鲸下新添加的所有任务**

```bash
task._bk_iam_path_ starts_with /project,蓝鲸ProjectID/task,*/
```

## 鉴权

鉴权传递的资源, 是`操作`关联对应的资源; 此时需要注意, 由于关联了实例视图, 使用拓扑来管理权限, 所以, 在鉴权的时候需要构造并传递`_bk_iam_path_`

**注意: 如果操作配置了实例视图, 并且实例视图是多层的, 那么必须构造并传递`_bk_iam_path_`**

`_bk_iam_path_`的值即当前实例的拓扑链路

上面的示例中, 实例视图是`project下的task`, 所以鉴权`view_task`的时候, 传递`task`实例需要的`_bk_iam_path_=/project,对应的project/`; 

如果操作配置了多个实例视图, 需要传递对应的`_bk_iam_path_`, 因为用户可能用任意一个视图申请权限; 如果少传递了, 对应的策略不会被命中, 会导致无权限.

### 1. SDK 鉴权

* [SDK 鉴权](../Reference/API/04-Auth/01-SDK.md)
* [QuickStart: 鉴权](../QuickStart/04-Auth.md)

```python
from iam import IAM, Request, Subject, Action, Resource


SYSTEM_ID = "bk_sops"
APP_CODE = ""
APP_SECRET = ""
BK_IAM_HOST = "http://{IAM_HOST}"
BK_PAAS_HOST = ''


class Permission(object):
    def __init__(self):
        self._iam = IAM(APP_CODE, APP_SECRET, BK_IAM_HOST, BK_PAAS_HOST)

    def _make_request_with_resources(self, username, action_id, resources):
        request = Request(
            SYSTEM_ID,
            Subject("user", username),
            Action(action_id),
            resources,
            None,
        )
        return request

    def allowed_task_view(self, username, task_id):
        """
        app开发权限
        """
        # get task project first, 这里假设一个task只属于一个project
        task = Task.Objects.get(id=task_id)
        project_id = task.project.id
        
        r = Resource(SYSTEM_ID, 'task', task_id, {
            "_bk_iam_path_": ["/project,%s/" % project_id],
        })
        
        resources = [r]
        request = self._make_request_with_resources(username, "task_view", resources)
        return self._iam.is_allowed(request)
```

### 2. 直接鉴权 API

[直接鉴权 API: policy auth](../Reference/API/04-Auth/02-DirectAPI.md)

```json
{
  "system": "bk_sops",
  "subject": {
    "type": "user",
    "id": "admin"
  },
  "action": {
    "id": "task_view"
  },
  "resources": [
    {
      "system": "bk_sops",
      "type": "task",
      "id": "test",
      "attribute": {
        "_bk_iam_path_": [
          "/project,蓝鲸ProjectID/"
        ]
      }
    }
  ]
}
```

## 资源反向拉取

* [资源反向拉取: 4. fetch_instance_info](../Reference/API/03-Callback/13-fetch_instance_info.md)

资源反向拉取获取一批实例属性的时候, 可能会要求接入系统返回实例的`_bk_iam_path_`属性, 按照规范返回即可



