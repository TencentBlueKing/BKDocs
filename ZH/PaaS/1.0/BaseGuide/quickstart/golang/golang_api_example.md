# 使用蓝鲸云 Golang API

## 申请 API 权限

访问蓝鲸云 API，必须要申请访问权限。

- 打开开发者中心，点击要申请资源权限的[蓝鲸应用]，具体如下

    ![-w2021](../../images/docs/dev_center.png)

- 点击[基本设置]，点击[云 API 权限]，选择相应的[API 系统]，具体如下

    ![-w2021](../../images/docs/api_show.png)

- 根据要实现的功能和 API 说明及文档，申请相应的单个/多个 API，具体如下

    ![-w2021](../../images/docs/apply_perm.png)

> 提示：无需申请权限的 API，默认拥有权限，无需申请

- 管理员审批后，可以查看资源的拥有权限
    
> 提示：现阶段，申请 API 权限通过后，会拥有 180 天的访问权限；而且为了方便用户的持续使用，如果半年内有访问，则自动续期半年；否则，邮件通知蓝鲸应用开发者手动续期。

## SDK 使用说明

在您的应用中如果要使用 Golang SDK API, 建议使用 `dep` 作为 Golang 的依赖包工具，在代码中调用了蓝鲸云 Golang API 时，使用命令：

```bash
dep ensure
```

该命令会下载依赖 Golang SDK 包。

> Golang 有多种包依赖管理工具，我们推荐您使用 `dep` ，[dep 学习文档](https://golang.github.io/dep/docs/introduction.html)

## SDK 使用示例

在创建蓝鲸 Golang 应用后，项目的源码包中已经包含一个蓝鲸云 Golang API 的使用示例，在 controllers 目录下有一个 esb_example_sdk.go 文件。

请阅读该示例来了解蓝鲸 Golang API 的使用。
