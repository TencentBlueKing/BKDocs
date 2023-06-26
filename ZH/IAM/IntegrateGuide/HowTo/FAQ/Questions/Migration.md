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

## 5. 已经有最新版的 APIGateway 且有权限中心网关, do_migrate如何切换?

注册权限模型也需要调用APIGateway接口，  需要替换一下[do_migrate.py文件](https://github.com/TencentBlueKing/iam-python-sdk/blob/0d9b67baa24144d3c84be12cc3cd4adfd487b74c/iam/contrib/iam_migration/utils/do_migrate.py) 

然后使用新命令执行，

`-t` 换成apigateway的 URL 之后, 多加一个 `--apigateway`

新命令样例如下：

```
python3 do_migrate.py -t http://bk-iam.apigw.blueking.com/prod -f ./demo_model.json -a "demo" -s "c2cfbc92-28a2-420c-b567-cf7dc33cf29f" --apigateway
```

## 6. 使用do_migrate.py+json 文件进行模型变更, 是否可以切换使用API维护?

本质上do_migrate做的upsert, 先查, 再更新, 如果存在, 调用 PUT, 如果不存在调用 POST

相关代码: [do_migrate.py](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/iam/contrib/iam_migration/utils/do_migrate.py#L469)

可以全部走注册接口注册, 通过接口维护 