# 样例 8: 系统间调用无权限申请

## 1. 场景描述

用户在使用 A 系统的功能, A 系统需要以用户的身份调用 B 系统的 API, B 系统检查发现用户没有权限; 

此时, B 系统需要将`用户需要在B系统申请的权限信息`返回给 A 系统 [第三方鉴权失败返回权限申请数据协议](../../Reference/API/05-Application/02-NoPermissionData.md)

然后页面上展示给用户, 通过 [生成无权限申请 URL](../../Reference/API/05-Application/01-GenerateURL.md) 生成权限申请 URL, 用户点击跳转到权限中心申请权限

## 2. 权限分析

- B 系统接口无权限, 按照 [第三方鉴权失败返回权限申请数据协议](../../Reference/API/05-Application/02-NoPermissionData.md) 返回数据, 需要注意填充`name`(调用方拿到要在页面展示的)
- A 系统将返回数据组织, 在页面展示 [无权限交互方案](../Solutions/NoPermissionApply.md), 此时`系统`这一列是`B`
- A 系统将返回数据 [生成无权限申请 URL](../../Reference/API/05-Application/01-GenerateURL.md) 生成权限申请 URL
- 用户点击按钮, 跳往权限中心, 申请`B`系统的权限

![-w2021](../../assets/HowTo/Examples/08_01.jpg)
