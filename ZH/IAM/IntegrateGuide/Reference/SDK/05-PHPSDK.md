# PHP SDK

php sdk 已经完成并开源

- [Github: TencentBlueKing/iam-php-sdk](https://github.com/TencentBlueKing/iam-php-sdk)
- 详细使用文档 [usage.md](https://github.com/TencentBlueKing/iam-php-sdk/blob/master/docs/usage.md)
- SDK 整体入口 `src/IAM.py`
- 测试用例 `tests/`

### Features

- 鉴权支持: isAllowed / isAllowedWithCache
- 单个操作批量资源鉴权: batchIsAllowed
- 单个资源批量操作鉴权: resourceMultiActionsAllowed
- 批量资源批量操作鉴权: batchResourceMultiActionsAllowed
- 生成无权限申请 URL: getApplyURL
- 资源反向拉取接口 basic auth 鉴权: isBasicAuthAllowed
- 获取系统 Token: getToken