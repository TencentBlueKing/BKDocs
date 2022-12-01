# 样例 3: 使用拓扑层级管理权限

## 相关阅读

> 拓扑层级管理权限涉及到实例视图的概念, 请先阅读相关的文档, 了解实例视图的概念

- [说明: 实例视图](../../Explanation/01-instanceSelection.md)
- [说明: 资源拓扑`_bk_iam_path_`](../../Explanation/04-BkIAMPath.md)

## 1. 场景描述

在业务实际模型中, 可能存在多层的`拓扑层级`关系, 例如`项目-模块-主机`.

此时, 配置`主机的查看权限`, 可以使用`拓扑层级`来配置

- 项目 A 下的所有主机
- 项目 A-模块 B 下的所有主机
- 项目 A-模块 B-主机 C 

此时, 注册模型权限中心支持配置`实例视图`, 实例视图链路中的每种资源类型即拓扑层级的每一级资源类型; `project-module-host`; 在申请权限的时候, 可以根据需求, 使用上层关系授权, 或者使用实例级别授权;

## 2. 权限分析

样例以标准云运维的`流程查看`为例, 其拓扑层级关系是`项目-流程模板`

- 需要注册资源类型 流程模板 `flow`
- 需要注册资源类型 项目 `project`
- 注册实例视图, 声明 `flow`实例的选择方式,  实例视图`instanceSelection=flow`,  是拓扑层级的关系, `project-flow`
- 注册操作  `flow_view`
    - 关联实例类型 `resourceType=flow`
    - 关联资源的实例视图 `flow.related_instance_selections=flow`




## 3. 权限模型

注册资源类型`project`和`flow`, 注意`flow`的拓扑层级的父级是`project`; 即, `项目/流程模板`

```json
{
  "id": "project",
  "name": "项目",
  "name_en": "project",
  "description": "",
  "description_en": "",
  "parents": [],
  "provider_config": {
    "path": "/iam/resource/api/v1/"
  },
  "version": 1
}


{
  "id": "flow",
  "name": "流程模板",
  "name_en": "flow",
  "description": "",
  "description_en": "",
  "parents": [
    {
      "system_id": "bk_sops",
      "id": "project"
    }
  ],
  "provider_config": {
    "path": "/iam/resource/api/v1/"
  },
  "version": 1
}
```

配置实例视图`flow`(决定了配置权限时, 如何选到 flow), 拓扑层级关系是, 选择`project`下的`flow`

```json
{
  "id": "flow",
  "name": "流程模板",
  "name_en": "Flow",
  "resource_type_chain": [
    {
      "system_id": "bk_sops",
      "id": "project"
    },
    {
      "system_id": "bk_sops",
      "id": "flow"
    }
  ]
}
```


注册操作`流程查看`, 关联资源类型 `flow`, 资源类型的 实例视图 `related_instance_selections` 是 `flow`

```json
{
  "id": "flow_view",
  "name": "流程查看",
  "name_en": "Flow View",
  "description": "",
  "description_en": "",
  "type": "view",
  "related_resource_types": [
    {
      "system_id": "bk_sops",
      "id": "flow",
      "related_instance_selections": [
        {
          "system_id": "bk_sops",
          "id": "flow"
        }
      ]
    }
  ],
  "version": 1
}
```

这样, 配置权限时, 实例视图中选择 flow 就会存在树状结构, 上级是`project`, 叶子节点是`flow`;

- 如果勾选了`project`, 代表这个项目下的所有流程模板有权限; 
    - 生成策略: `__bk_iam_path__ startswith /project,123/`
- 如果勾选了具体某个`flow`, 代表仅对某个项目下这个具体的流程模板有权限;
    - 生成策略: `__bk_iam_path__ startswith /project,123/ AND flow.id eq "abc"`

![-w2021](../../assets/HowTo/Examples/03_01.jpg)


## 4. 鉴权

需要注意, Resource 传递 attribute 中包含一个字段`__bk_iam_path__`, 这个字段格式具体查看  [说明: 资源拓扑`_bk_iam_path_`](../../Explanation/04-BkIAMPath.md)

`/project,abc/`代表`task 123`是`project abc`下的一个流程.

```bash
[
        Resource(
            "bk_sops",
            "task",
            123,
            {
                "iam_resource_owner": "tom",
                "_bk_iam_path_": ["/project,abc/"],
                "name": "test_task",
                "type": "flow"
            },
        )
    ]
```


## 5. 无权限申请

[生成无权限申请 URL](../../Reference/API/05-Application/01-GenerateURL.md)中, 使用`instances`进行拓扑层级的权限申请; 

例如
- `instances[0]`中的`resources`列表只包含了`project=a`, 代表申请`project a`下的所有`flow`的查看权限; 
- 如果包含了`project=a, flow=b`,   代表申请`project a`下的`flow b`的查看权限;
