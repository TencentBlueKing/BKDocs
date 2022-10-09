# do_migrate 相关

## 1. do_migrate 执行 upsert_action_groups 为什么只有最后一个生效

全局只有一个`action_groups`列表，只做一次操作，配置多个`upsert_action_groups`每一个都会覆盖前面的导致最后只有一个生效

所以应该用`action_groups`列表来支持多个操作而不是调用多次`upsert_action_groups`

## 2. do_migrate 执行结果 conflict: xxxx  already exists

`ID/中文名/英文名`等, 要求系统内唯一, 如果出现`conflict: xxxx already exists`, 说明之前注册过, 现在插入的和之前的有冲突.

具体每种资源的限制, 详见 [模型注册 API](../../../Reference/API/02-Model/00-API.md)

需要:
1. 如果是不同资源, 需要确保不冲突
2. 如果是同一个资源变更 ID, 需要先删除老的, 再插入新的

## 3. do_migrate 如果我使用 django 框架怎么进行 iam migration

可以使用 python sdk 中集成到 django migration 中, 具体文档: [iam-python-sdk](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/docs/usage.md#2-iam-migration)

## 4. do_migrate 是否可以重复执行同一个文件 

`add_*` 的操作会报错, 因为第二次执行时跟已有资源冲突了. 

`update_*`操作需要确保资源存在

`upsert_*` 操作不存在则创建/存在则更新. 建议尽量使用`upsert`操作
