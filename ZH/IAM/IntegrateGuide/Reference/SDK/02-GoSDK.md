# Go SDK

Go 版 SDK 目前仅完成基本的鉴权逻辑

- [Github: TencentBlueKing/iam-go-sdk](https://github.com/TencentBlueKing/iam-go-sdk)
- 详细使用文档 [usage.md](https://github.com/TencentBlueKing/iam-go-sdk/blob/master/docs/usage.md)


### Features

- 鉴权支持: IsAllowed / IsAllowedWithCache
- 单个操作批量资源鉴权: BatchIsAllowed
- 单个资源批量操作鉴权: ResourceMultiActionsAllowed
- 批量资源批量操作鉴权: BatchResourceMultiActionsAllowed
- 生成无权限申请 URL: GetApplyURL
- 生成无权限协议 json: GenPermissionApplyData
- 资源反向拉取接口 basic auth 鉴权: IsBasicAuthAllowed  / 以及 basic auth middleware
- 获取系统 Token: GetToken
- 支持 prometheus 统计接口调用信息
- 支持反向拉取框架 dispatcher/provider interface