# 资源反向拉取相关

## 1. 权限中心`资源反向拉取`调用接入系统接口拉取资源时的 token 如何获取 

调用接口获取, 详细文档见  [系统间接口鉴权](../../../Reference/API/01-Overview/03-APIAuth.md) / [系统 token 查询 API](../../../Reference/API/02-Model/16-Token.md)

建议缓存在内存中(确保升级/重启时重新拉取), 不建议放 redis 中(安全问题/更新未重新拉取)

## 2. 资源反向拉取接口各自对应页面上哪些展示

- fetch_instance_info 无权限申请/新建关联/跨系统资源依赖等场景, 会到接入系统拉取资源信息;
- list_instance_by_policy 权限预览[前端暂未实现]