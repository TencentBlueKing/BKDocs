# Python SDK

python 版 SDK 已经基本完成, 可以参考其代码/使用文档/单元测试用例

- [Github: TencentBlueKing/iam-python-sdk](https://github.com/TencentBlueKing/iam-python-sdk)
- 详细使用文档 [usage.md](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/docs/usage.md)
- SDK 整体入口 `iam/iam.py`
- 测试用例 `tests/`

### Features

- [Basic] 兼容 Python2/Python3
- [Basic] 完备的单元测试
- [Basic] 支持 debug 调试完整流程
- [IAM] 支持条件表达式求值: 策略查询/鉴权/获取有权限的用户列表
- [IAM] 支持条件表达式解析: 转换成 Django QuerySet 及 SQL 语句
- [IAM] 获取无权限申请跳转 URL
- [IAM] 支持批量资源鉴权 / 支持批量资源批量 action 是否有权限判断
- [Contrib] Django IAM Migration, 整合 iam 模型 migration 到 Django Migration
- [Contrib] Resource API Framework, 协助构建需要提供给 IAM 调用的 Resource API
- [Contrib] 支持 tastypie
