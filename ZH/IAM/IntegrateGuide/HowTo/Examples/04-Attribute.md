# 样例 4: 使用属性管理权限

## 1. 场景描述

使用属性来进行授权, 可以达到`范围授权`的目的, 即, 通过`资源的属性`进行权限管理.

例如:
- 主机有一个分类属性, `type=db`表示数据库主机, `type=redis`表示 redis 主机
- 可以配置查看权限, 使用 `type=db`, 则用户拥有所有`type=db`的主机的查看权限; 

注意, 这个属性指的是`资源属性`, 鉴权的时候, 需要带上相应的属性`key-value`

## 2. 权限分析

这个样例中, 我们以标准运维的任务查看为例, 任务查看支持属性授权; 

- 有一个资源类型`task`
- task 拥有两个属性用于权限配置 1. type 任务类型 2. iam_resource_owner 资源创建者
- 操作`task_view`任务查看, 支持使用属性配置权限

## 3. 权限模型

注册操作

注意, 操作的`task_view`关联的资源类型是`task`, 其`selection_mode=all` 表示, 同时支持使用 `选择实例`和`配置属性`;

即, 支持使用属性授权

```json
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
```

此时产品页面的申请入口, 配置页面回调了 [资源反向拉取 API](../../Reference/API/03-Callback/01-API.md)中的`list_attr`和`list_attr_value`(即接入系统如果配置了属性, 需要实现相应的回调接口)


![-w2021](../../assets/HowTo/Examples/04_01.jpg)


## 4. 鉴权

鉴权逻辑同 [样例 2: 关联简单实例权限](./02-ActionWithResource.md) 一致, 只是鉴权参数中, resource 需要带上 `attribute` 字典; 

```python
r = Resource(SYSTEM_ID, 'app', app_code, {"iam_resource_owner": "tom"})
```

## 5. 无权限申请

逻辑同 [样例 2: 关联简单实例权限](./02-ActionWithResource.md) 一致

[生成无权限申请 URL](../../Reference/API/05-Application/01-GenerateURL.md) 协议中, 申请属性授权, 配置的是`attributes`字段
