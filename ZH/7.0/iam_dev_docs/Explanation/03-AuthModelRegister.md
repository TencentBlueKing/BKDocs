# 权限模型注册的几种方式

> 本文重点阐述开发者构建好权限模型之后, 如何将权限模型注册到权限中心

开发者可以根据权限中心的文档, 构建好权限模型; 或者通过`页面接入`功能, 在表单中填写后导出权限模型数据.


## 1. 使用模型注册 API 注册

使用模型注册 API, 直接将权限模型注册到权限中心;

- [模型注册 API](../Reference/API/02-Model/00-API.md)
- 示例 [QuickStart: 模型注册](../QuickStart/03-Model.md)

适用:
- 非 python(Django)开发的系统
- 权限模型变更不频繁的系统
- 中大型系统, 可以通过代码及模型配置, 自己完成初始化(需要自行确保注册顺序)

## 2. 使用 do_migrate.py

将模型数据转化成 json 文件, 使用脚本进行模型注册; 推荐操作代码`operation`使用`upsert_XXX`

- [权限模型自动初始化及更新 migration](../HowTo/Solutions/Migration.md)

适用:
- 模型变更频繁的系统
- 不想开发及维护模型注册代码/配置, 通过 json 完成模型数据注册及更新(json 文件及每个操作位置, 决定了最终注册顺序)

## 3. 使用 Django migration

如果开发者使用 Django 开发的系统, 那么可以利用[iam-python-sdk](https://github.com/TencentBlueKing/iam-python-sdk)提供的 `IAM Migration`, 将模型注册集成到`Django Migration`中

- [iam-python-sdk: iam migration](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/docs/usage.md#2-iam-migration)

适用:
- 使用 Django 开发的系统